import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tenfoldlit_mobile/searchAndFilters/models/book.dart';
import 'package:tenfoldlit_mobile/searchAndFilters/screens/search.dart';



class BookPage extends StatefulWidget {
    const BookPage({Key? key}) : super(key: key);

    @override
    _BookResultsPageState createState() => _BookResultsPageState();
}

class _BookResultsPageState extends State<BookPage> {
Future<List<Book>> fetchProduct() async {
    var url = Uri.parse(
        'http://127.0.0.1:8000/json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Book> list_book = [];
    for (var d in data) {
        if (d != null) {
            list_book.add(Book.fromJson(d));
        }
    }
    return list_book;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Book'),
        ),
        // drawer: const LeftDrawer(),
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
                                    "${snapshot.data![index].fields.name}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    // const SizedBox(height: 10),
                                    // Text("${snapshot.data![index].fields.price}"),
                                    // const SizedBox(height: 10),
                                    // Text(
                                    //     "${snapshot.data![index].fields.description}")
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}