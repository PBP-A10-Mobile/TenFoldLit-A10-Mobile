import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/authentication/screens/login.dart';
import 'dart:convert';
import 'package:tenfoldlit_mobile/catalog/models/book.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookResultsPageState createState() => _BookResultsPageState();
}

class _BookResultsPageState extends State<BookPage> {
  String _date = "";
  String date = "";
  Future<List<Book>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Book> listBook = [];
    for (var d in data) {
      if (d != null) {
        listBook.add(Book.fromJson(d));
      }
    }
    return listBook;
  }

  Future<void> addToFavorites(int bookId) async {
    var url = Uri.parse('http://127.0.0.1:8000/add_to_favorites/$bookId/');

    try {
      var response = await http.post(url);

      if (response.statusCode == 200) {
        print('Book added to favorites: $bookId');
      } else {
        print('Failed to add book to favorites: $bookId');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book'),
      ),
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "No book data.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data![index].fields.title}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              addToFavorites(snapshot.data![index].id);
                            },
                            child: Text('Add to Favorites'),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (loggedIn) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        String borrowUntil = 'Borrow until : ';

                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return AlertDialog(
                                              title: Text(
                                                borrowUntil,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              content: ElevatedButton(
                                                onPressed: () async {
                                                  final DateTime? picked =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate:
                                                        DateTime(2015, 8),
                                                    lastDate: DateTime(2101),
                                                  );
                                                  if (picked != null) {
                                                    setState(() {
                                                      date = picked
                                                          .toIso8601String()
                                                          .split('T')[0]
                                                          .toString();
                                                      _date = date;
                                                      borrowUntil =
                                                          'Borrow until : ' +
                                                              date;
                                                    });
                                                  }
                                                },
                                                child: Text('Pick borrow date'),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Submit'),
                                                  onPressed: () async {
                                                    String url =
                                                        'http://127.0.0.1:8000/borrow-books-flutter/';
                                                    url += snapshot
                                                        .data![index].pk
                                                        .toString();
                                                    print(
                                                        DateTime.parse(_date));
                                                    final response =
                                                        await request.postJson(
                                                            url,
                                                            jsonEncode(<String,
                                                                String>{
                                                              "date_ended":
                                                                  _date
                                                            }));
                                                    if (response['status'] ==
                                                        'success') {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            "Berhasil meminjam buku!"),
                                                      ));
                                                      Navigator.pop(context);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            "Gagal. Buku sedang dipinjam."),
                                                      ));
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  }
                                },
                                child: Text('Borrow Book'),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
