import 'package:flutter/material.dart';
import 'package:roll_dice/pages/pageExpense/pageExpenses.dart';
import 'package:roll_dice/pages/pageRNG/pageRNG.dart';

class PageLibrary extends StatelessWidget {
  PageLibrary({super.key});

  Map<String, Widget> pages = {
    "RNG": const PageRNG(),
    "Expenses": const PageExpenses(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: pages.entries.map((entry) {
            return Bookmark(title: entry.key, page: entry.value);
          }).toList(),
        ),
      ),
    );
  }
}

class Bookmark extends StatelessWidget {
  String title;
  Widget page;
  Bookmark({super.key, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Container(
          padding: EdgeInsets.all(4),
          color: const Color(0xFFD90429),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }
}
