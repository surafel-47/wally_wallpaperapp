// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/Explore/explore.dart';
import 'package:wallpaperapp/Home/home.dart';
import 'package:wallpaperapp/MyProfile/myProfile.dart';
import 'package:wallpaperapp/Datas.dart';

class MainBoard extends StatefulWidget {
  const MainBoard({super.key});

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  int selIndex = 0;
  List<Widget> items = [Home(), Explore(), MyProfile()];

  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyWallAppDatas>(context, listen: true);
    myDatas
        .loadLikedPhotosToList(); //loading liked photos array as soon as app is started
    return Scaffold(
      body: Container(
        color: myDatas.isDarkMode() ? Colors.black : Colors.white,
        child: IndexedStack(
          index: selIndex,
          children: items,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: myDatas.isDarkMode() ? Colors.white : Colors.black,
        backgroundColor: myDatas.isDarkMode()
            ? const Color.fromARGB(255, 30, 30, 30)
            : Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          FocusScope.of(context)
              .unfocus(); //--------------------------------------------------------------
          selIndex = value;
          setState(() {});
        },
        currentIndex: selIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My Profile",
          ),
        ],
      ),
    );
  }
}
