import 'package:flutter/material.dart';
class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF2F2F2),
              prefixIcon: const Icon(Icons.search), // Search icon
              labelText: 'Search',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          )),
        ],
      ),
    );
  }
}
