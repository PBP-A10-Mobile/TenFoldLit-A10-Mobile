import 'package:flutter/material.dart';
import 'package:tenfoldlit_mobile/homepage/widgets/left_drawer.dart';
import 'package:tenfoldlit_mobile/searchAndFilters/screens/search.dart';
import 'package:tenfoldlit_mobile/catalog/screens/book_list.dart';
import 'package:tenfoldlit_mobile/myLibrary/screens/user_library.dart';
import 'package:tenfoldlit_mobile/catalog/screens/my_favorite.dart';
import 'package:tenfoldlit_mobile/authentication/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class FeatureContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const FeatureContainer({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  String selectedGenre = ''; // Default value
  List<String> genres = []; // Default list with 'All' option

  @override
  Widget build(BuildContext context) {
    final request =
        context.watch<CookieRequest>(); // Assuming CookieRequest is a provider

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TenfoldLit",
          style: TextStyle(color: Colors.white, fontFamily: 'Times New Roman'),
        ),
        backgroundColor:
            Color.fromARGB(255, 149, 116, 81), // Set app bar color to brown
      ),
      drawer: LeftDrawer(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 240, 204),
            boxShadow: const [BoxShadow(color: Colors.brown, blurRadius: 2.0)],
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Adjust the padding as needed
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'Search Books',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => _navigateToBookResultsPage(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/logo.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 139, 108, 75), // Set container color to brown
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Our Features",
                      style: TextStyle(
                        color: Color.fromARGB(
                            255, 255, 255, 255), // Set text color to cream
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 10),
                  // Menu buttons
                  Wrap(
                    spacing: 20, // horizontal spacing
                    runSpacing: 20, // vertical spacing
                    children: <Widget>[
                      FeatureContainer(
                        title: 'Catalog',
                        icon: Icons.category,
                        onTap: () => navigateToPage(context, const BookPage()),
                      ),
                      FeatureContainer(
                        title: 'My Library',
                        icon: Icons.library_books,
                        onTap: () {
                          if (!request.loggedIn) {
                            navigateToPage(context, const LoginApp());
                          } else {
                            navigateToPage(context, const MyLibraryPage());
                          }
                        },
                      ),
                      FeatureContainer(
                        title: 'My Favorite',
                        icon: Icons.star,
                        onTap: () {
                          if (!request.loggedIn) {
                            navigateToPage(context, const LoginApp());
                          } else {
                            navigateToPage(context, const MyFavoritesPage());
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToBookResultsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookResultsPage(
          searchQuery: _searchController.text,
          genre: selectedGenre,
        ),
      ),
    );
  }

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
