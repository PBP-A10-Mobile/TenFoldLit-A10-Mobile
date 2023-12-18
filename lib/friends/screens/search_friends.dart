import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/friends/models/UserConnections.dart';
import 'package:tenfoldlit_mobile/friends/models/user.dart';
import 'package:tenfoldlit_mobile/friends/models/userProfile.dart';
import 'package:tenfoldlit_mobile/friends/screens/friends.dart';

class SearchFriendsPage extends StatefulWidget {
    const SearchFriendsPage({Key? key}) : super(key: key);

    @override
    _SearchFriendsPageState createState() => _SearchFriendsPageState();
}

class _SearchFriendsPageState extends State<SearchFriendsPage> {
  TextEditingController _searchController = TextEditingController();
  
  Future<List<User>> fetchAllUsers() async {
    final request = context.watch<CookieRequest>();
    var url = 'http://10.0.2.2:8000/get_all_user_connections_object/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Item
    List<User> listUsers = [];
    for (var temp in response) {
      var user = User.fromJson(temp);
      listUsers.add(user);
    }
    return listUsers;
  }

  Future<List<User>> fetchFriends() async {
    final request = context.watch<CookieRequest>();
    var url = 'http://10.0.2.2:8000/get_friends/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Item
    var friends = UserConnections.fromJson(response[0]);
    int pk = friends.pk;
    var url2 = 'http://10.0.2.2:8000/get_friends_user_objects/$pk';
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
    var url = 'http://10.0.2.2:8000/get_user_profile/$userId/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Item
    var profile = Profile.fromJson(response[0]);
    return profile;
  }

  Future<User> fetchCurrentUser() async {
    final request = context.watch<CookieRequest>();
    var url = 'http://10.0.2.2:8000/get_current_user/';
    var response = await request.get(url);

    var currentUser = User.fromJson(response[0]);
    return currentUser;
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to another page when the back button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FriendsPage()),
            );
          },
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 240, 204),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade50,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                        future: fetchCurrentUser(),
                        builder: (context, AsyncSnapshot<User> currentUserSnapshot) {
                            if (!currentUserSnapshot.hasData) {
                              return const SizedBox.shrink(); // Handle loading state if needed
                            } else {
                              var currentUser = currentUserSnapshot.data!;
                              return FutureBuilder(
                                future: fetchFriends(),
                                builder: (context, AsyncSnapshot<List<User>> friendsSnapshot) {
                                  if (!friendsSnapshot.hasData) {
                                    return const SizedBox.shrink(); // Handle loading state if needed
                                  } else {
                                    List<User> friendsList = friendsSnapshot.data!;
                                    return FutureBuilder(
                                      future: fetchAllUsers(),
                                      builder: (context, AsyncSnapshot<List<User>> snapshot) {
                                        if (!snapshot.hasData || snapshot.data!.length == 1) {
                                          return SizedBox(
                                            height: 500,
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  "You are the only one here!"
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
                                        
                                          filteredUsers.removeWhere((user) => user.userId == currentUser.userId);
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: filteredUsers.length,
                                            itemBuilder: (_, index) {
                                              User currentUser = filteredUsers[index];
                                              int currentUserId = currentUser.userId;
                                              int currentUserConnectionsId = currentUser.userConnectionId;
                                              bool isFollowed =
                                                  friendsList.any((friend) => friend.userId == currentUserId);
                            
                                              return Container(
                                                margin: const EdgeInsets.symmetric(vertical: 5),
                                                padding: const EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    FutureBuilder(
                                                      future: fetchUserProfile(currentUserId),
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
                                                                        "${currentUser.username}",
                                                                        style: const TextStyle(
                                                                          fontSize: 18.0,
                                                                          fontWeight: FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed: () async {
                                                                          if (!isFollowed) {
                                                                            // If not already followed, call followUser function
                                                                            var url = 'http://10.0.2.2:8000/follow_friend_flutter/$currentUserConnectionsId/';
                                                                            await request.post(url, null);
                                                                      
                                                                            // Update the UI
                                                                            setState(() {});
                                                                          }
                                                                        },
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        color: isFollowed
                                                                            ? Colors.grey
                                                                            : Colors.brown.shade400,
                                                                        child: Text(
                                                                          isFollowed ? 'Followed' : 'Follow',
                                                                          style: TextStyle(
                                                                              color: isFollowed ? Colors.black : Colors.white,
                                                                              fontSize: 14,
                                                                            ),
                                                                        ),
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
                                            },
                                          );
                                        }
                                      },
                                    );
                                  }
                                },
                              );
                          }
                        }
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      )
      
    );
  }
}