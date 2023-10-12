import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/Datas.dart';

class CatagorySelectWidget extends StatelessWidget {
  double scrW = 0;
  double scrH = 0;
  String selItem = "All";
  List<String> itemss = [
    "All",
    "Backgrounds",
    "Food",
    "Nature",
    "Animals",
    "Music",
    "Sports",
    "Travel",
    "Buildings",
    "Fashion"
  ];
  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyWallAppDatas>(context, listen: true);

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return Container(
      width: scrW * 0.8,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Categories',
          labelStyle: TextStyle(
              fontSize: scrW * 0.06,
              fontWeight: FontWeight.bold,
              color: myDatas.isDarkMode() ? Colors.white : Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                width: 1),
          ),
        ),
        child: Material(
          color: myDatas.isDarkMode() ? Colors.black : Colors.white,
          child: DropdownButton(
            menuMaxHeight: scrH * 0.4,
            value: selItem,
            items: itemss.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: TextStyle(
                    color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              myDatas.setCategory(value!);
            },
          ),
        ),
      ),
    );
  }
}
