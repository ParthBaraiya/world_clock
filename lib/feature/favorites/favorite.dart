import 'package:flutter/material.dart';

part 'favorite_page.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Your favorites comes here,...'),
    );
  }
}
