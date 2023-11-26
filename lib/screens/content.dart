import 'package:flutter/material.dart';

class ContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie/TV Show Details'),
      ),
      body: Center(
        child: Text('Details about the selected Movie/TV Show'),
      ),
    );
  }
}
