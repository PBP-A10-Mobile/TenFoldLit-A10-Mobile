// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    int id;
    String title;
    DateTime dateEnded;
    String bookImage;
    String author;
    Bookformat bookformat;
    String desc;
    String genre;
    String isbn;
    String isbn13;
    String link;
    int pages;
    double rating;
    int reviews;
    int totalratings;

    Book({
        required this.id,
        required this.title,
        required this.dateEnded,
        required this.bookImage,
        required this.author,
        required this.bookformat,
        required this.desc,
        required this.genre,
        required this.isbn,
        required this.isbn13,
        required this.link,
        required this.pages,
        required this.rating,
        required this.reviews,
        required this.totalratings,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        dateEnded: DateTime.parse(json["date_ended"]),
        bookImage: json["book_image"],
        author: json["author"],
        bookformat: bookformatValues.map[json["bookformat"]]!,
        desc: json["desc"],
        genre: json["genre"],
        isbn: json["isbn"],
        isbn13: json["isbn13"],
        link: json["link"],
        pages: json["pages"],
        rating: json["rating"]?.toDouble(),
        reviews: json["reviews"],
        totalratings: json["totalratings"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date_ended": "${dateEnded.year.toString().padLeft(4, '0')}-${dateEnded.month.toString().padLeft(2, '0')}-${dateEnded.day.toString().padLeft(2, '0')}",
        "book_image": bookImage,
        "author": author,
        "bookformat": bookformatValues.reverse[bookformat],
        "desc": desc,
        "genre": genre,
        "isbn": isbn,
        "isbn13": isbn13,
        "link": link,
        "pages": pages,
        "rating": rating,
        "reviews": reviews,
        "totalratings": totalratings,
    };
}

enum Bookformat {
    AUDIOBOOK,
    HARDCOVER,
    MASS_MARKET_PAPERBACK,
    PAPERBACK
}

final bookformatValues = EnumValues({
    "Audiobook": Bookformat.AUDIOBOOK,
    "Hardcover": Bookformat.HARDCOVER,
    "Mass Market Paperback": Bookformat.MASS_MARKET_PAPERBACK,
    "Paperback": Bookformat.PAPERBACK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
