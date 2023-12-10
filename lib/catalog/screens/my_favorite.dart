import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({Key? key}) : super(key: key);

  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    var url = Uri.parse('http://127.0.0.1:8000/my_favorites/');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: FutureBuilder(
        future: fetchFavorites(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(
                child: Text('You have no favorite books.'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${snapshot.data[index]['name']}'),
                    subtitle: Text('Rating: ${snapshot.data[index]['rating']}'),
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
