import 'package:flutter/material.dart';
import 'package:tenfoldlit_mobile/catalog/models/book.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookDetailPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 116, 81),
        title: const Text(
          'Book Detail', // Access the book property
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          color: const Color.fromARGB(255, 255, 240, 204),
          child: Column(
            children: [
              Text(widget.book.fields.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.book.fields.img, 
                    fit: BoxFit.cover, 
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 65,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 55,),
                          Column(
                            children: [
                              Text("Rating", style: TextStyle(fontSize: 15, color: Colors.brown.shade500, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 3,),
                              Text(widget.book.fields.rating.toString(), style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                          const SizedBox(width: 55,),
                          const VerticalDivider(color: Colors.black, thickness: 1,),
                          const SizedBox(width: 55,),
                          Column(
                            children: [
                              Text("Pages", style: TextStyle(fontSize: 15, color: Colors.brown.shade500, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 3,),
                              Text(widget.book.fields.pages.toString(), style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text("Author:", textAlign: TextAlign.right, style: TextStyle(fontSize: 19, color: Colors.brown.shade500, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 3,),
                    Text(widget.book.fields.author, style: const TextStyle(fontSize: 17),),
                    const SizedBox(height: 15,),
                    Text("Genre:", textAlign: TextAlign.right, style: TextStyle(fontSize: 19, color: Colors.brown.shade500, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 3,),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 350), // Set your desired maxWidth
                      child: Text(
                        widget.book.fields.genre,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text("ISBN:", textAlign: TextAlign.right, style: TextStyle(fontSize: 19, color: Colors.brown.shade500, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 3,),
                    Text(widget.book.fields.isbn, style: const TextStyle(fontSize: 17),),
                    const SizedBox(height: 15,),
                    Text("Description:", textAlign: TextAlign.right, style: TextStyle(fontSize: 19, color: Colors.brown.shade500, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 3,),
                    Container(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.fields.desc, 
                              textAlign: TextAlign.justify, 
                              style: const TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
