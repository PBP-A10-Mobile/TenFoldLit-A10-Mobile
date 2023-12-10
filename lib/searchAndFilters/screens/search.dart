import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:tenfoldlit_mobile/searchAndFilters/models/book.dart';
import 'package:tenfoldlit_mobile/searchAndFilters/widgets/dropdownmenu.dart';
import '';
// Import your Book model and fetchBooks function

class BookResultsPage extends StatefulWidget {
  final String searchQuery;
  final String genre;

  BookResultsPage({required this.searchQuery, this.genre = ' '});

  @override
  _BookResultsPageState createState() => _BookResultsPageState();
}

class _BookResultsPageState extends State<BookResultsPage> {
  String genre = '';

  Future<List<Book>> fetchBooks(
      CookieRequest request, String searchQuery, String genre) async {
    String url = '';

    if (searchQuery.isNotEmpty || genre.isNotEmpty) {
      if (searchQuery.isNotEmpty) {
        url = 'http://127.0.0.1:8000/get_search_books/' + searchQuery;
      }
      if (genre.isNotEmpty) {
        url = 'http://127.0.0.1:8000/get_filtered_books/'+ genre;
      }
    } else {
      throw Exception('Sorry the books you looking for is not found :(');
    }

    var response = await request.get(url);

    List<Book> books = [];

    for (var d in response) {
      if (d != null) {
        books.add(Book.fromJson(d));
      }
    }
    // print(books);
    return books;
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
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                        ],
                      ),
                    ),
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
