// popular_now_screen.dart
import 'package:flutter/material.dart';

class TrendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Now'),
      ),
      body: Center(
        child: Text('List of Trending Movies/TV Series'),
      ),
    );
  }
}
