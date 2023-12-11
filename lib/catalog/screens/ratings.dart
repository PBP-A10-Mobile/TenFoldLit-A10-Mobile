import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RatingsPage extends StatefulWidget {
  const RatingsPage({Key? key}) : super(key: key);

  @override
  _RatingsPageState createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
  Future<List<Map<String, dynamic>>> fetchRatings() async {
    var url = Uri.parse('http://127.0.0.1:8000/json');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load ratings');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ratings'),
      ),
      body: FutureBuilder(
        future: fetchRatings(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(
                child: Text('No ratings available for this book.'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Rating: ${snapshot.data[index]['rating']}'),
                    subtitle:
                        Text('Comment: ${snapshot.data[index]['comment']}'),
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
