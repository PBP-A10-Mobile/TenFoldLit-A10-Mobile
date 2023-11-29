// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    int pk;
    Model model;
    Fields fields;

    Book({
        required this.pk,
        required this.model,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        pk: json["pk"],
        model: modelValues.map[json["model"]]!,
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "model": modelValues.reverse[model],
        "fields": fields.toJson(),
    };
}

class Fields {
    String author;
    Bookformat bookformat;
    String desc;
    String genre;
    String img;
    dynamic isbn;
    int isbn13;
    String link;
    int pages;
    double rating;
    int reviews;
    String title;
    int totalratings;

    Fields({
        required this.author,
        required this.bookformat,
        required this.desc,
        required this.genre,
        required this.img,
        required this.isbn,
        required this.isbn13,
        required this.link,
        required this.pages,
        required this.rating,
        required this.reviews,
        required this.title,
        required this.totalratings,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        author: json["author"],
        bookformat: bookformatValues.map[json["bookformat"]]!,
        desc: json["desc"],
        genre: json["genre"],
        img: json["img"],
        isbn: json["isbn"],
        isbn13: json["isbn13"],
        link: json["link"],
        pages: json["pages"],
        rating: json["rating"]?.toDouble(),
        reviews: json["reviews"],
        title: json["title"],
        totalratings: json["totalratings"],
    );

    Map<String, dynamic> toJson() => {
        "author": author,
        "bookformat": bookformatValues.reverse[bookformat],
        "desc": desc,
        "genre": genre,
        "img": img,
        "isbn": isbn,
        "isbn13": isbn13,
        "link": link,
        "pages": pages,
        "rating": rating,
        "reviews": reviews,
        "title": title,
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

enum Model {
    MAIN_BOOK
}

final modelValues = EnumValues({
    "main.book": Model.MAIN_BOOK
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
