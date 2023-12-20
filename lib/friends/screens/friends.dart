import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/friends/models/UserConnections.dart';
import 'package:tenfoldlit_mobile/friends/models/user.dart';
import 'package:tenfoldlit_mobile/friends/models/userProfile.dart';
import 'package:tenfoldlit_mobile/friends/screens/search_friends.dart';
import 'package:tenfoldlit_mobile/friends/screens/user_profile.dart';
import 'package:tenfoldlit_mobile/homepage/widgets/left_drawer.dart';

class FriendsPage extends StatefulWidget {
    const FriendsPage({Key? key}) : super(key: key);

    @override
    _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  TextEditingController _searchController = TextEditingController();


  Future<List<User>> fetchFriends() async {
    final request = context.watch<CookieRequest>();
    var url = 'https://tenfoldlit-a10-tk.pbp.cs.ui.ac.id/get_friends/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Item
    var friends = UserConnections.fromJson(response[0]);
    int pk = friends.pk;
    var url2 = 'https://tenfoldlit-a10-tk.pbp.cs.ui.ac.id/get_friends_user_objects/$pk';
    var users = await request.get(url2);
    List<User> listFriends = [];
    for (var temp in users) {
      var user = User.fromJson(temp);
      listFriends.add(user);
    }
    return listFriends;
  }

  Future<Profile> fetchUserProfile(int userId) async {
    final request = context.watch<CookieRequest>();
    var url = 'https://tenfoldlit-a10-tk.pbp.cs.ui.ac.id/get_user_profile/$userId/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Item
    var profile = Profile.fromJson(response[0]);
    return profile;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 116, 81),
        title: const Text(
          'Friends',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        color: const Color.fromARGB(255, 255, 240, 204),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  width: 250,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade50,
                  ),
                  margin: const EdgeInsets.only(left: 20.0, right: 10),
                  child: TextField(
                    controller: _searchController,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      setState(() {}); // Trigger a rebuild to update the displayed list
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                      suffixIcon: const Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 30,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SearchFriendsPage()));
        
                    _refreshIndicatorKey.currentState?.show();
                  },
                  shape: RoundedRectangleBorder(                                    
                    borderRadius: BorderRadius.circular(7)
                  ),
                  color: const Color.fromARGB(255, 53, 113, 143),
                  child: const Row(
                    children: [
                      Text("Add", style: TextStyle(fontSize: 13, color: Colors.white),),
                      SizedBox(width: 7,),
                      Icon(Icons.group_add_outlined, color: Colors.white, size: 20,),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchFriends(),
                builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return SizedBox(
                    height: 500,
                    child: Container(
                      child: const Center(
                        child: Text(
                          "You don't have any friends yet."
                        )
                      )
                    )
                  );
                } else {
                    List<User> filteredUsers = _searchController.text.isNotEmpty
                      ? snapshot.data!.where((User user) {
                          return user.username
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase());
                        }).toList()
                      : List.from(snapshot.data!);
                    return ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (_, index) {
                        User currentUser = filteredUsers[index];
                        int currentUserConnectionsId = currentUser.userConnectionId;
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                              future: fetchUserProfile(currentUser.userId),
                              builder: (context, AsyncSnapshot profileSnapshot) {
                                if (!profileSnapshot.hasData) {
                                  return const SizedBox.shrink(); 
                                } else {
                                  return Container(
                                    height: 120,
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
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
                                          margin: const EdgeInsets.only(right: 15),
                                          child: profileSnapshot.hasData && profileSnapshot.data.profile != null
                                            ? Image.network(profileSnapshot.data.profile!)
                                            : const Icon(Icons.account_circle_outlined, size: 50,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                currentUser.username,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => UserProfilePage(user: currentUser)),
                                                      );                           
                                                    },
                                                    shape: RoundedRectangleBorder(                           
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    color: Colors.black,
                                                    child: const Text(
                                                      'See Profile', 
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        ),
                                                      ),
                                                  ),
                                                  const SizedBox(width: 13,),
                                                  MaterialButton(
                                                    onPressed: () async {
                                                      var url = 'https://tenfoldlit-a10-tk.pbp.cs.ui.ac.id/unfollow_friend_flutter/$currentUserConnectionsId/';
                                                      await request.post(url, null);
                                                      
                                                      // Update the UI
                                                      setState(() {});
                                                
                                                      // Refresh the FutureBuilder
                                                      _refreshIndicatorKey.currentState?.show();                
                                                    },
                                                    shape: RoundedRectangleBorder(                                    
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    color: const Color.fromARGB(255, 244, 45, 45),
                                                    child: const Text('Unfollow', 
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      }
                    ); 
                  }
                }),
            )
          ],
        ),
      )
      
    );
  }
}