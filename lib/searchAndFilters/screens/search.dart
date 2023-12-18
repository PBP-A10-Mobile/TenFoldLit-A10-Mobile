import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/authentication/screens/login.dart';
import 'dart:convert';
import 'package:tenfoldlit_mobile/searchAndFilters/models/book.dart';
import 'package:tenfoldlit_mobile/searchAndFilters/widgets/dropdownmenu.dart';

class BookResultsPage extends StatefulWidget {
  final String searchQuery;
  final String genre;

  BookResultsPage({required this.searchQuery, this.genre = ' '});

  @override
  _BookResultsPageState createState() => _BookResultsPageState();
}

class _BookResultsPageState extends State<BookResultsPage> {
  String _date = "";
  String date = "";
  String genre = '';
  bool showFullDescription = false; // Track whether to show full description

  Future<List<Book>> fetchBooks(
      CookieRequest request, String searchQuery, String genre) async {
    String url = '';

    if (searchQuery.isNotEmpty || genre.isNotEmpty) {
      if (searchQuery.isNotEmpty) {
        url = 'http://127.0.0.1:8000/get_search_books/' + searchQuery;
      }
      if (genre.isNotEmpty) {
        url = 'http://127.0.0.1:8000/get_filtered_books/' + genre;
      }
    } else {
      throw Exception('Sorry, the books you are looking for are not found :(');
    }

    var response = await request.get(url);

    List<Book> books = [];

    for (var d in response) {
      if (d != null) {
        books.add(Book.fromJson(d));
      }
    }

    return books;
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
      appBar: AppBar(title: Text('Search Results')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenuExample(
              onGenreChanged: (newGenre) {
                setState(() {
                  genre = newGenre;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchBooks(request, widget.searchQuery, genre),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width ~/
                          150, // Adjust as needed
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
                          // Wrap the Card's content with SingleChildScrollView
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
                                    height:
                                        150, // Adjust this value to change the height of the image
                                    width:
                                        100, // Adjust this value to change the width of the image
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
                                      Row(
                                        children: [
                                          TextButton(
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
                                                color: Color.fromARGB(
                                                    255, 187, 158, 108),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: TextButton(
                                              onPressed: () {
                                                if (loggedIn) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      String borrowUntil =
                                                          'Borrow until : ';

                                                      return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setState) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              borrowUntil,
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                            content:
                                                                ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                final DateTime?
                                                                    picked =
                                                                    await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2015,
                                                                          8),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2101),
                                                                );
                                                                if (picked !=
                                                                    null) {
                                                                  setState(() {
                                                                    date = picked
                                                                        .toIso8601String()
                                                                        .split(
                                                                            'T')[0]
                                                                        .toString();
                                                                    _date =
                                                                        date;
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
                                                                child: Text(
                                                                    'Submit'),
                                                                onPressed:
                                                                    () async {
                                                                  String url =
                                                                      'http://127.0.0.1:8000/borrow-books-flutter/';
                                                                  url += snapshot
                                                                      .data![
                                                                          index]
                                                                      .pk
                                                                      .toString();
                                                                  print(DateTime
                                                                      .parse(
                                                                          _date));
                                                                  final response =
                                                                      await request.postJson(
                                                                          url,
                                                                          jsonEncode(<String,
                                                                              String>{
                                                                            "date_ended":
                                                                                _date
                                                                          }));
                                                                  if (response[
                                                                          'status'] ==
                                                                      'success') {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      content: Text(
                                                                          "Berhasil meminjam buku!"),
                                                                    ));
                                                                    Navigator.pop(
                                                                        context);
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      content: Text(
                                                                          "Gagal. Buku sedang dipinjam."),
                                                                    ));
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
                                                      builder: (context) =>
                                                          LoginPage(),
                                                    ),
                                                  );
                                                }
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 151, 115, 44),
                                              ),
                                              child: const Text(
                                                'Borrow',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
