import 'package:flutter/material.dart';
import 'package:tenfoldlit_mobile/screens/menu.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
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
              // Replace the code with the navigation logic for the 'Friends' page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const FriendsPage(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('My Library'),
            // Redirection ke InventoryPageForm
            onTap: () {
              // Replace the code with the navigation logic for the 'My Library' page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const MyLibraryPage(),
              //   ),
              // );
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
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            // Redirection ke InventoryPageForm
            onTap: () {
              // Replace the code with the navigation logic for the 'My Favorite' page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const LoginPage(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
