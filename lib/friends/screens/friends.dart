import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:tenfoldlit_mobile/friends/models/UserConnections.dart';
import 'package:tenfoldlit_mobile/friends/models/user.dart';
import 'package:tenfoldlit_mobile/homepage/widgets/left_drawer.dart';
import 'dart:developer';

class FriendsPage extends StatefulWidget {
    const FriendsPage({Key? key}) : super(key: key);

    @override
    _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
Future<List<UserConnections>> fetchFriends() async {
  final request = context.watch<CookieRequest>();
  var url = 'http://127.0.0.1:8000/get_friends/';
  var response = await request.get(url);


  // melakukan konversi data json menjadi object Item
    List<UserConnections> list_userconnections = [];
    for (var d in response) {
        if (d != null) {
            list_userconnections.add(UserConnections.fromJson(d));
        }
    }
    return list_userconnections;
}

Future<List<User>> fetchUser(int userId) async {
  final request = context.watch<CookieRequest>();
  var url = 'http://127.0.0.1:8000/get_user/$userId';
  var response = await request.get(url);
  
  List<User> user_data = [];
  for (var d in response) {
    user_data.add(User.fromJson(d));
  }
  return user_data;
}

@override
Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();
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
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: fetchFriends(),
                builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                    } else {
                        if (!snapshot.hasData) {
                        return const Column(
                            children: [
                            Text(
                                "Anda belum mempunyai teman.",
                                style:
                                    TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                            ),
                            SizedBox(height: 8),
                            ],
                        );
                    } else {
                        return ListView.builder(
                          shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                  future: fetchUser(snapshot.data![index].fields.friends), 
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.data == null) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else {
                                      return Text(
                                        "${snapshot.data.fields.username}",
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                  })
                                ],
                              ),
                          ));
                        }
                    }
                })
            ],
          )
        )
        
      );
    }
}