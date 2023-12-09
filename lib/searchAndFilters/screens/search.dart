import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:tenfoldlit_mobile/searchAndFilters/models/book.dart';
import '';
// Import your Book model and fetchBooks function

class BookResultsPage extends StatefulWidget {
  final String searchQuery;
  final String genre;

  BookResultsPage({required this.searchQuery, this.genre = ''});

  @override
  _BookResultsPageState createState() => _BookResultsPageState();
}

class _BookResultsPageState extends State<BookResultsPage> {
  Future<List<Book>> fetchBooks(CookieRequest request, String searchQuery, String genre) async {
    String url;

  if (searchQuery.isNotEmpty && genre.isEmpty){
    url = 'http://127.0.0.1:8000/get_search_books/';
  }
  else{
    url = 'http://127.0.0.1:8000/get_filtered_books/';
  }
  
  if (searchQuery.isNotEmpty || genre.isNotEmpty) {
    if (searchQuery.isNotEmpty) {
      url += searchQuery ;
    }
    if (genre.isNotEmpty) { 
      url += genre ;
    }
  } else {
    throw Exception('Sorry the books you looking for is not found :(');
  }

  var response = await request.get(url);

  List<Book> books = [];

  for (var d in response){
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
      body: FutureBuilder(
            future: fetchBooks(request, widget.searchQuery, widget.genre),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data Buku.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
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
                                  // Can you
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}


