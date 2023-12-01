import 'package:flutter/material.dart';
import 'package:tenfoldlit_mobile/searchAndFiilters/screens/search.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TenfoldLit',
          style: TextStyle(
            color: Colors.white,
            ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search Books',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _navigateToBookResultsPage(context),
                  ),
                ),
              ),
              // ... other widgets or menu items ...
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
        builder: (context) => BookResultsPage(searchQuery: _searchController.text),
      ),
    );
  }
}