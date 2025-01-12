import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            movie['image'] != null
                ? Image.network(movie['image']['original'])
                : Icon(Icons.error),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie['name'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ?? 'No Summary Available',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
