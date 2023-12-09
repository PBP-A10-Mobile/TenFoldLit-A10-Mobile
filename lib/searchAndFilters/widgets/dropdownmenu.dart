import 'package:flutter/material.dart';
import 'package:tenfoldlit_mobile/searchAndFilters/screens/search.dart';

const List<String> list = <String>[
  'Nonfiction', 'History', 'Games', 'Esoterica', 'Poetry', 'Cultural', 
  'Religion', 'Romance', 'Prayer', 'History', 'Chess', 'Astrology', 
  'Canada', 'Sequential', 'Theology', 'Christian', 'Evangelism', 
  'Christianity', 'Science', 'Biography', 'Military'
];

void main() => runApp(const DropdownMenuApp());

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownMenu Sample')),
        body: const Center(
          child: DropdownMenuExample(),
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({Key? key}) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookResultsPage(
              searchQuery: '',
              genre: dropdownValue,
            ),
          ),
        );
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
