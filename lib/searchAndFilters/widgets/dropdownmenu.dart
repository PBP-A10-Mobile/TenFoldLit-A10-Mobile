import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/searchAndFilters/screens/search.dart';

const List<String> list = ['Nonfiction', 'History', 'Games', 'Esoterica', 'Poetry', 'Cultural', 'Religion', 'Romance', 
'Prayer', 'History', 'Chess', 'Astrology', 'Canada', 'Sequential', 'Theology', 'Christian', '40k', 'Christianity', 
'Science', 'Biography', 'Military', 'Tv', 'Classics', 'Entrepreneurship', 'Basketball', 'Combat', 'Storytime', 'Management', 
'Economics', 'Contemporary Romance', 'Medieval History', 'Spirituality', 'Folklore', 'School', 'Religion', 'Brazil', 'Islam', 
'Archaeology', 'Civil War', 'Sports', 'Kids', 'Germany', 'Money', 'Mythology', 'Culture', 'Games', 'Zen', 'M M M', 'Chick Lit', 
'Art', 'Education', 'Erotica', 'Spy Thriller', 'Humor', 'Personal Finance', 'Christianity', 'Horses', 'Theology', 'Nazi Party', 
'Mathematics', 'Memoir'];


class DropdownMenuExample extends StatefulWidget {
  final Function(String) onGenreChanged;

  const DropdownMenuExample(
      {required this.onGenreChanged, Key? key})
      : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  Future<void> updateBooks(String? newValue) async {
    if (newValue != null) {
      setState(() {
        dropdownValue = newValue;
      });
      widget.onGenreChanged(dropdownValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Color.fromARGB(255, 148, 103, 48), width: 2),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.keyboard_arrow_down, color: Color.fromARGB(255, 148, 103, 48)),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
          onChanged: updateBooks,
          items: list.toSet().toList() // Remove duplicates
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
