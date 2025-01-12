import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to search movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onSubmitted: searchMovies,
            ),
          ),
          Expanded(
            child: searchResults.isEmpty
                ? Center(child: Text('No Results Found'))
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = searchResults[index]['show'];
                      return ListTile(
                        leading: Image.network(
                          movie['image'] != null
                              ? movie['image']['medium']
                              : '',
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.error),
                        ),
                        title: Text(movie['name']),
                        subtitle: Text(
                            movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                                ''),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
