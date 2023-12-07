import 'package:flutter/material.dart';
import 'package:tenfoldlit_mobile/homepage/widgets/left_drawer.dart';
import 'package:tenfoldlit_mobile/searchAndFilters/screens/search.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  String selectedGenre = ''; // Default value
  List<String> genres = []; // Default list with 'All' option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TenfoldLit",
          style: TextStyle(color: Colors.white, fontFamily: 'Times New Roman'),
        ),
        backgroundColor: Color.fromARGB(255, 149, 116, 81), // Set app bar color to brown
      ),
      drawer: LeftDrawer(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 240, 204),
            // borderRadius: BorderRadius.circular(20),
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
              // DropdownButton<String>(
              //   value: selectedGenre,
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       selectedGenre = newValue ?? 'All';
              //     });
              //   },
              //   items: genres.map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // )
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
                      color: Color.fromARGB(255, 139, 108, 75), // Set container color to brown
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "TenfoldLit",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255), // Set text color to cream
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
                      color:  Color.fromARGB(255, 139, 108, 75), // Set container color to brown
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Welcome to TenfoldLit! You can explore our book collections by clicking this button below!",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255), // Set text color to cream
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
                            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(255, 139, 108, 75), // Set button color to brown
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
                      color: Color.fromARGB(255, 139, 108, 75), // Set container color to brown
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
        builder: (context) => BookResultsPage(
          searchQuery: _searchController.text,
          genre: selectedGenre,
          ),
      ),
    );
  }
}
