import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  void _onSearch() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResult = 'Please enter a search query';
      });
    } else {
      setState(() {
        _searchResult = 'No result found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF2F2F2),
                  prefixIcon: const Icon(Icons.search),
                  labelText: 'Search App',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onSearch,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            if (_searchResult.isNotEmpty)
              Text(
                _searchResult,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
