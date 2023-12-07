// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    String model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    dynamic user;
    String title;
    String author;
    String bookformat;
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
    bool status;

    Fields({
        required this.user,
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
        required this.status,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        author: json["author"],
        bookformat: json["bookformat"],
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
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "author": author,
        "bookformat": bookformat,
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
        "status": status,
    };
}
