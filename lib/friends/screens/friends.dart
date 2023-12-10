import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/friends/models/UserConnections.dart';
import 'package:tenfoldlit_mobile/friends/models/user.dart';
import 'package:tenfoldlit_mobile/friends/screens/search_friends.dart';
import 'package:tenfoldlit_mobile/homepage/widgets/left_drawer.dart';

class FriendsPage extends StatefulWidget {
    const FriendsPage({Key? key}) : super(key: key);

    @override
    _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  Future<List<User>> fetchFriends() async {
    final request = context.watch<CookieRequest>();
    var url = 'http://127.0.0.1:8000/get_friends/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Item
    var friends = UserConnections.fromJson(response[0]);
    int pk = friends.pk;
    var url2 = 'http://127.0.0.1:8000/get_friends_user_objects/$pk';
    var users = await request.get(url2);
    List<User> listFriends = [];
    for (var temp in users) {
      var user = User.fromJson(temp);
      listFriends.add(user);
    }
    return listFriends;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                width: 170,
                height: 40,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SearchFriendsPage()));
                  },
                  shape: RoundedRectangleBorder(                                    
                    borderRadius: BorderRadius.circular(7)
                  ),
                  color: const Color.fromARGB(255, 53, 113, 143),
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(width: 10,),
                        const Text('Add new friend', style: TextStyle(color: Colors.white),),
                        const SizedBox(width: 10,),
                        Icon(Icons.group_add_outlined, color: Colors.white,)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: fetchFriends(),
                builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "You don't have any friends yet.",
                        style: TextStyle(color: Colors.black, fontSize: 20),
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
                            horizontal: 16, vertical: 5),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 110,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              )
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  margin: EdgeInsets.only(right: 15),
                                  child: Icon(Icons.account_circle_outlined, size: 50,),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${snapshot.data[index].username}",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                                                                    
                                            },
                                            shape: RoundedRectangleBorder(                           
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            color: Colors.brown.shade400,
                                            child: const Text('See Profile', style: TextStyle(color: Colors.white),),
                                          ),
                                          const SizedBox(width: 10,),
                                          MaterialButton(
                                            onPressed: () {
                                                                                    
                                            },
                                            shape: RoundedRectangleBorder(                                    
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            color: Color.fromARGB(255, 244, 45, 45),
                                            child: const Text('Unfollow', style: TextStyle(color: Colors.white),),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                            ]),
                          )
                          ],
                        ),
                      ));
                    }
                })
            ],
          )
        ),
      )
      
    );
  }
}