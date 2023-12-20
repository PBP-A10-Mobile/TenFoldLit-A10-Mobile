import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:tenfoldlit_mobile/catalog/models/book.dart';

class RatingsPage extends StatefulWidget {
  const RatingsPage({Key? key}) : super(key: key);

  @override
  _RatingsPageState createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
  Future<List<Book>> fetchRatings() async {
    final request = context.watch<CookieRequest>();
    var url = 'https://tenfoldlit-a10-tk.pbp.cs.ui.ac.id/ratings_json/';

    var response = await request.get(url);
      List<Book> listBook = [];
      for (var temp in response) {
        var book = Book.fromJson(temp);
        listBook.add(book);
      }
      return listBook;
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ratings'),
      ),
      body: FutureBuilder(
        future: fetchRatings(),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No ratings available for this book.'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Title: ${snapshot.data![index].fields.title}'),
                    subtitle: Column(
                      children: [
                        Container(
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            snapshot.data![index].fields.img,
                            fit: BoxFit.cover, 
                          ),
                        ),
                      ),
                        Text('Rating: ${snapshot.data![index].fields.rating}'),
                      ],
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