import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/authentication/screens/login.dart';
import 'package:tenfoldlit_mobile/friends/screens/friends.dart';
import 'package:tenfoldlit_mobile/homepage/screens/menu.dart';
import 'package:tenfoldlit_mobile/myLibrary/screens/user_library.dart';
import 'package:tenfoldlit_mobile/searchAndFilters/screens/search.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
            child: Column(
              children: [
                Text(
                  'TenfoldLit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Hello!",
                  style: TextStyle(
                    color: Color.fromARGB(100, 50, 100, 3),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            // Redirection ke InventoryPageForm
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  BookResultsPage(searchQuery: '%20',),
                ),
              );
            },
          ),
          if (loggedIn) ... [
          ListTile(
            leading: const Icon(Icons.man),
            title: const Text('Profile'),
            // Redirection ke InventoryPageForm
            onTap: () {
              // Replace the code with the navigation logic for the 'Profile' page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ProfilePage(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Friends'),
            // Redirection ke InventoryPageForm
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FriendsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('My Library'),
            // Redirection ke InventoryPageForm
            onTap: () {
              if (loggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyLibraryPage(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
              // Replace the code with the navigation logic for the 'My Library' page
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_half_outlined),
            title: const Text('My Favorite'),
            // Redirection ke InventoryPageForm
            onTap: () {
              // Replace the code with the navigation logic for the 'My Favorite' page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const MyFavoritePage(),
              //   ),
              // );
            },
          )],
          ListTile(
            leading: Icon(
                loggedIn ? Icons.logout_outlined : Icons.login_outlined),
            title: Text(loggedIn ? 'Logout' : 'Login'),
            onTap: () async {
              if (loggedIn) {
                final response = await request
                    .logout("http://127.0.0.1:8000/logout_flutter/");
                String message = response["message"];
                loggedIn = false;
                if (response['status']) {
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message Sampai jumpa, $uname."),
                  ));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message"),
                  ));
                }
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
