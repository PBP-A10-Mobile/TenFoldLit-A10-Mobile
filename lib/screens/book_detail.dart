import 'package:flutter/material.dart';
import 'package:tenfoldlit_mobile/catalog/models/book.dart';
import 'package:tenfoldlit_mobile/catalog/screens/my_favorite.dart';
import 'package:tenfoldlit_mobile/catalog/screens/ratings.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({Key? key}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Book _book;

  @override
  void initState() {
    super.initState();
    _book = ModalRoute.of(context)!.settings.arguments as Book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_book.fields.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Penulis: ${_book.fields.author}'),
            Text('Genre: ${_book.fields.genre}'),
            // informasi buku lainnya nantian

            // Tombol untuk menavigasi ke halaman RatingsPage
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RatingsPage(),
                  ),
                );
              },
              child: Text('Lihat Ratings'),
            ),

            // Tombol untuk menavigasi ke halaman MyFavoritesPage
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyFavoritesPage(),
                  ),
                );
              },
              child: Text('Lihat Favorit'),
            ),
          ],
        ),
      ),
    );
  }
}
