import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tenfoldlit_mobile/models/book.dart';
// Import your Book model and fetchBooks function

class BookResultsPage extends StatefulWidget {
  final String searchQuery;

  BookResultsPage({required this.searchQuery});

  @override
  _BookResultsPageState createState() => _BookResultsPageState();
}

class _BookResultsPageState extends State<BookResultsPage> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks(widget.searchQuery).then((fetchedBooks) {
      setState(() {
        books = fetchedBooks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Results')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index].fields.title),
            subtitle: Text(books[index].fields.author),
            // Add more book details here
          );
        },
      ),
    );
  }
}

Future<List<Book>> fetchBooks(String query) async {
  
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/json/'));

  if (response.statusCode == 200) {
    List<dynamic> booksJson = json.decode(response.body);
    return booksJson.map((json) => Book.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load books');
  }
}
