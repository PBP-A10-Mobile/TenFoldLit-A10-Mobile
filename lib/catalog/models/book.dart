// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'dart:convert';

List<Books> booksFromJson(String str) =>
    List<Books>.from(json.decode(str).map((x) => Books.fromJson(x)));

String booksToJson(List<Books> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Books {
  Model model;
  int pk;
  Fields fields;

  Books({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String title;
  String author;
  Bookformat bookformat;
  String desc;
  String img;
  String genre;
  String isbn;
  String isbn13;
  String link;
  int pages;
  double rating;
  int reviews;
  int totalratings;
  dynamic userAvgRating;

  Fields({
    required this.title,
    required this.author,
    required this.bookformat,
    required this.desc,
    required this.img,
    required this.genre,
    required this.isbn,
    required this.isbn13,
    required this.link,
    required this.pages,
    required this.rating,
    required this.reviews,
    required this.totalratings,
    required this.userAvgRating,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
        bookformat: bookformatValues.map[json["bookformat"]]!,
        desc: json["desc"],
        img: json["img"],
        genre: json["genre"],
        isbn: json["isbn"],
        isbn13: json["isbn13"],
        link: json["link"],
        pages: json["pages"],
        rating: json["rating"]?.toDouble(),
        reviews: json["reviews"],
        totalratings: json["totalratings"],
        userAvgRating: json["user_avg_rating"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "bookformat": bookformatValues.reverse[bookformat],
        "desc": desc,
        "img": img,
        "genre": genre,
        "isbn": isbn,
        "isbn13": isbn13,
        "link": link,
        "pages": pages,
        "rating": rating,
        "reviews": reviews,
        "totalratings": totalratings,
        "user_avg_rating": userAvgRating,
      };
}

enum Bookformat { AUDIOBOOK, HARDCOVER, MASS_MARKET_PAPERBACK, PAPERBACK }

final bookformatValues = EnumValues({
  "Audiobook": Bookformat.AUDIOBOOK,
  "Hardcover": Bookformat.HARDCOVER,
  "Mass Market Paperback": Bookformat.MASS_MARKET_PAPERBACK,
  "Paperback": Bookformat.PAPERBACK
});

enum Model { MAIN_BOOK }

final modelValues = EnumValues({"main.book": Model.MAIN_BOOK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
