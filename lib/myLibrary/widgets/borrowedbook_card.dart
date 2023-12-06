import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BorrowedBooksDetails {
  final Image image;
  final String title;
  final String date_ended;

  BorrowedBooksDetails(
      this.image, this.title, this.date_ended);
}

class BorrowedBooksCard extends StatelessWidget {
  final BorrowedBooksDetails book;

  const BorrowedBooksCard(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Card(
      child: ListTile(
        leading: book.image,
        title: Text(book.title),
        subtitle: Text('Due on: ${book.date_ended.substring(0, 10)}'),
        trailing: ElevatedButton(
          onPressed: () {
            // Add your return book functionality here
          },
          child: Text('Return Book'),
        ),
      ),
    );
  }
}