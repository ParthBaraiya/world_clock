import 'package:flutter/material.dart';

import '../../values/breakpoints.dart';
import '../../widget/responsive_split_widget.dart';
import '../home/home.dart';

part 'favorite_page.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Your favorites comes here,..."),
    );
  }
}
