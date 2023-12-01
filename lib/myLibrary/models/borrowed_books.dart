// To parse this JSON data, do
//
//     final borrowedBooks = borrowedBooksFromJson(jsonString);

import 'dart:convert';

List<BorrowedBooks> borrowedBooksFromJson(String str) => List<BorrowedBooks>.from(json.decode(str).map((x) => BorrowedBooks.fromJson(x)));

String borrowedBooksToJson(List<BorrowedBooks> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BorrowedBooks {
    int id;
    String title;
    DateTime dateEnded;
    String bookImage;

    BorrowedBooks({
        required this.id,
        required this.title,
        required this.dateEnded,
        required this.bookImage,
    });

    factory BorrowedBooks.fromJson(Map<String, dynamic> json) => BorrowedBooks(
        id: json["id"],
        title: json["title"],
        dateEnded: DateTime.parse(json["date_ended"]),
        bookImage: json["book_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date_ended": "${dateEnded.year.toString().padLeft(4, '0')}-${dateEnded.month.toString().padLeft(2, '0')}-${dateEnded.day.toString().padLeft(2, '0')}",
        "book_image": bookImage,
    };
}
