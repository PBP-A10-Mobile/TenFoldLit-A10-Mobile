import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/authentication/screens/login.dart';
import 'dart:convert';
import 'package:tenfoldlit_mobile/catalog/models/book.dart';
import 'package:tenfoldlit_mobile/catalog/screens/book_detail.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookResultsPageState createState() => _BookResultsPageState();
}

class _BookResultsPageState extends State<BookPage> {
  String _date = "";
  String date = "";
  bool showFullDescription = false;
  Future<List<Book>> fetchProduct() async {
    var url = Uri.parse('https://tenfoldlit-a10-tk.pbp.cs.ui.ac.id/json/');
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

  void _navigateToBookDetailPage(BuildContext context, Book currentBook) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(book: currentBook,),
      ),
    );
  }

  String truncateDescription(String description, int maxLength) {
    if (description.length <= maxLength) {
      return description;
    }
    return '${description.substring(0, maxLength)}...';
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
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                  childAspectRatio: 0.7,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  Book book = snapshot.data![index];
                  String description = showFullDescription
                      ? book.fields.desc
                      : truncateDescription(book.fields.desc, 10);
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                book.fields.img,
                                height: 150,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${book.fields.title}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${book.fields.author}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  "Rating: ${book.fields.rating}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  "Description: $description",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                                if (book.fields.desc.length > 10)
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          showFullDescription =
                                              !showFullDescription;
                                        });
                                      },
                                      child: Text(
                                        showFullDescription
                                            ? "See Less"
                                            : "See More",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 187, 158, 108),
                                        ),
                                      ),
                                    ),
                                  ),
                                Center(
                                  child: ElevatedButton(
                                        onPressed: () {
                                          _navigateToBookDetailPage(context, book);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                        ),
                                        child: const Text(
                                          'Book Detail',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 151, 115, 44)),
                                        ),
                                      ),
                                ),
                                SizedBox(width: 8),
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      if (loggedIn) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            String borrowUntil =
                                                'Borrow until : ';
                                                    
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return AlertDialog(
                                                  title: Text(
                                                    borrowUntil,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  content: ElevatedButton(
                                                    onPressed: () async {
                                                      final DateTime? picked =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2015, 8),
                                                        lastDate:
                                                            DateTime(2101),
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
                                                    child: Text(
                                                        'Pick borrow date'),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('Submit'),
                                                      onPressed: () async {
                                                        String url =
                                                            'https://tenfoldlit-a10-tk.pbp.cs.ui.ac.id/borrow-books-flutter/';
                                                        url +=
                                                            book.pk.toString();
                                                        print(DateTime.parse(
                                                            _date));
                                                        final response =
                                                            await request
                                                                .postJson(
                                                          url,
                                                          jsonEncode(<String,
                                                              String>{
                                                            "date_ended": _date,
                                                          }),
                                                        );
                                                        if (response[
                                                                'status'] ==
                                                            'success') {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  "Berhasil meminjam buku!"),
                                                            ),
                                                          );
                                                          Navigator.pop(
                                                              context);
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  "Gagal. Buku sedang dipinjam."),
                                                            ),
                                                          );
                                                          Navigator.pop(
                                                              context);
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
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 151, 115, 44),
                                    ),
                                    child: const Text(
                                      'Borrow',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
