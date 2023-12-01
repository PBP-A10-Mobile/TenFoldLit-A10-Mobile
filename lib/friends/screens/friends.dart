import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tenfoldlit_mobile/friends/models/UserConnections.dart';
import 'package:tenfoldlit_mobile/homepage/widgets/left_drawer.dart';

class FriendsPage extends StatefulWidget {
    const FriendsPage({Key? key}) : super(key: key);

    @override
    _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
Future<List<UserConnections>> fetchFriends() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://127.0.0.1:8000/get_friends/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var dataUser = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<UserConnections> friends_list = [];
    for (var friend in dataUser[0].fields.friends) {
        if (friend != null) {
            friends_list.add(UserConnections.fromJson(friend));
        }
    }
    return friends_list;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text(
            'Friends',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        drawer: const LeftDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // const SizedBox(
              //   height: 20,
              // ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        )
        
      );
    }
}