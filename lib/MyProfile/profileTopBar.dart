// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:wallpaperapp/Datas.dart';
import 'package:provider/provider.dart';

class ProfileTopBar extends StatelessWidget {
  double scrW = 0;
  double scrH = 0;

  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyWallAppDatas>(context, listen: true);

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return Container(
      height: scrH * 0.1,
      decoration: BoxDecoration(
        color: myDatas.isDarkMode() ? Colors.black : Colors.white,
        boxShadow: [
          BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 20,
              color: myDatas.isDarkMode()
                  ? Color.fromARGB(255, 33, 74, 108)
                  : Color.fromARGB(255, 162, 156, 156),
              spreadRadius: 3),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.favorite, size: scrW * 0.13, color: Colors.red),
          ),
          Text(
            "Liked Photos",
            style: TextStyle(
              fontSize: scrW * 0.07,
              color: myDatas.isDarkMode() ? Colors.white : Colors.black,
            ),
          ),
          Expanded(child: Text(" ")),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: PopupMenuButton(
                color: myDatas.isDarkMode() ? Colors.black : Colors.white,
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: LiteRollingSwitch(
                        value: true,
                        animationDuration: Duration(milliseconds: 200),
                        width: scrW * 0.2,
                        textOff: "",
                        textOn: "",
                        iconOff: Icons.light_mode_outlined,
                        iconOn: Icons.dark_mode_outlined,
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                        textOnColor: Colors.white,
                        textOffColor: Colors.black,
                        colorOn: Colors.black,
                        colorOff: Color.fromARGB(255, 209, 202, 202),
                        onChanged: (value) {
                          myDatas.setDarkMode(value);
                        },
                      ),
                      onTap: () {},
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(Icons.info_outline,
                            color: myDatas.isDarkMode()
                                ? Colors.white
                                : Colors.black),
                        contentPadding: EdgeInsets.symmetric(horizontal: 3),
                        title: Text(
                          "About",
                          style: TextStyle(
                            color: myDatas.isDarkMode()
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      onTap: () {},
                    )
                  ];
                },
                child: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  size: scrW * 0.09,
                  color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
