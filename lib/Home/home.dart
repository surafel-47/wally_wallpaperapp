// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/Datas.dart';
import 'package:wallpaperapp/Home/picsGridView.dart';
import 'SearchFilter/searchFilter.dart';

class Home extends StatelessWidget {
  double scrW = 0;
  double scrH = 0;
  final textFieldValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyWallAppDatas>(context, listen: true);

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: scrH * 0.03),
        Row(
          children: [
            SizedBox(width: scrH * 0.02),
            Container(
              width: scrW * 0.8,
              height: scrH * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                boxShadow: [
                  BoxShadow(
                      color: myDatas.isDarkMode()
                          ? Color.fromARGB(255, 20, 16, 56)
                          : const Color.fromARGB(255, 203, 193, 193),
                      blurRadius: 5,
                      spreadRadius: 5),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: TextField(
                  controller: textFieldValue,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        myDatas.isDarkMode() ? Colors.black : Colors.white, //
                    border: myDatas.isDarkMode()
                        ? OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 3),
                            borderRadius: BorderRadius.circular(20.0),
                          )
                        : InputBorder.none,
                    suffixIcon: InkWell(
                      onTap: () {
                        myDatas.setQuery(textFieldValue.text);
                        //-----------------------------------------------maybe Errrrrrrrrorrr
                        myDatas.displayData();
                      },
                      child: const Icon(Icons.search),
                    ),
                    hintText: 'Search Wallpapers!',
                    hintStyle: TextStyle(
                        color:
                            myDatas.isDarkMode() ? Colors.white : Colors.black),
                    prefix: const Text("    "),
                  ),
                  focusNode: null,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SearchFilter();
                  },
                );
              },
              icon: Icon(Icons.filter_list_outlined,
                  color: myDatas.isDarkMode() ? Colors.white : Colors.black),
            ),
          ],
        ),
        SizedBox(height: scrH * 0.03),
        PicsGridView(),
      ],
    );
  }
}
