import 'package:flutter/material.dart';
import 'package:wallpaperapp/cardDisplay.dart';
import 'popularAndRecent.dart';

class Explore extends StatelessWidget {
  double scrW = 0;
  double scrH = 0;

  @override
  Widget build(BuildContext context) {
    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PopularAndRecent(recentOrPopular: "popular"),
          PopularAndRecent(recentOrPopular: "latest"),
        ],
      ),
    );
  }
}
