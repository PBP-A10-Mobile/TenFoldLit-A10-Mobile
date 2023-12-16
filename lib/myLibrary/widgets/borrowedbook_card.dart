import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BorrowedBooksDetails {
  final int id;
  final Image image;
  final String title;
  final String date_ended;

  BorrowedBooksDetails(this.id, this.image, this.title, this.date_ended);
}

class BorrowedBooksCard extends StatelessWidget {
  final BorrowedBooksDetails book;
  final Function() onDelete;

  const BorrowedBooksCard(this.book, this.onDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Card(
      color: Color.fromARGB(255, 255, 233, 182),
      child: ListTile(
        leading: book.image,
        title: Text(book.title),
        subtitle: Text('Due on: ${book.date_ended.substring(0, 10)}'),
        trailing: ElevatedButton(
          
          onPressed: () async {
            String url = 'http://127.0.0.1:8000/return-book/';
            url += book.id.toString();
            var response = await request.post(url, null);

            onDelete();
          },
          child: Text('Return Book',
                style: TextStyle(color: Color.fromARGB(255, 255, 240, 204))),
          style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.brown),
        ),
        ),
      ),
    );
  }
}
