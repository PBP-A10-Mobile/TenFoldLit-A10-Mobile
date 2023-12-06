import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:tenfoldlit_mobile/myLibrary/models/borrowed_books.dart';
import 'package:tenfoldlit_mobile/homepage/widgets/left_drawer.dart';
import 'package:tenfoldlit_mobile/myLibrary/widgets/borrowedbook_card.dart';

class MyLibraryPage extends StatefulWidget {
  const MyLibraryPage({Key? key}) : super(key: key);

  @override
  _MyLibraryPageState createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  Future<List<BorrowedBooks>> fetchProduct(request) async {

    var response = await request.get(
      'http://127.0.0.1:8000/get-borrowed-books/',
    );

    // melakukan decode response menjadi bentuk json

    // melakukan konversi data json menjadi object Product
    List<BorrowedBooks> list_book = [];
    for (var d in response) {
      if (d != null) {
        list_book.add(BorrowedBooks.fromJson(d));
      }
    }
    return list_book;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Library',
          ),
        ),
        drawer: const LeftDrawer(),

    body: FutureBuilder(
          future: fetchProduct(request),
          builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
              } else {
                  if (!snapshot.hasData) {
                  return const Column(
                      children: [
                      Text(
                          "Tidak ada data buku.",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                      ],
                  );
              } else {
                  return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => BorrowedBooksCard(
                                BorrowedBooksDetails(
                                    Image.network(snapshot.data![index].bookImage), // assuming image is a URL
                                    snapshot.data![index].title,
                                    snapshot.data![index].dateEnded.toString()
                                ),
                            ),
                        );
                  }
              }
          }));
  }
}
