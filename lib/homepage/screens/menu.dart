import 'package:flutter/material.dart';
import 'package:tenfoldlit_mobile/homepage/widgets/left_drawer.dart';
import 'package:tenfoldlit_mobile/searchAndFilters/screens/search.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TenfoldLit",
          style: TextStyle(color: Colors.white, fontFamily: 'Times New Roman'),
        ),
        backgroundColor: Colors.brown, // Set app bar color to brown
      ),
      drawer: LeftDrawer(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lime[200], // Set background color to cream
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.brown, blurRadius: 2.0)],
          ),
          
          child: Column(
            children: [
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
                      color: Colors.brown, // Set container color to brown
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "TenfoldLit",
                      style: TextStyle(
                        color: Colors.lime[700], // Set text color to cream
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.brown, // Set container color to brown
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Welcome to TenfoldLit! You can explore our book collections by clicking this button below!",
                          style: TextStyle(
                            color: Colors.lime[700], // Set text color to cream
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const KATALOGBUKU(),
                            //   ),
                            // );
                          },
                          child: Text(
                            'Start Reading',
                            style: TextStyle(color: Colors.lime[700]),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Colors.brown, // Set button color to brown
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.brown, // Set container color to brown
                      borderRadius: BorderRadius.circular(20),
                    ),
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
        builder: (context) => BookResultsPage(searchQuery: _searchController.text),
      ),
    );
  }
}
