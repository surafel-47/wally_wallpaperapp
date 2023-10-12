// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'orientationSelect.dart';
import 'mainColorSelect.dart';
import 'catagorySelect.dart';

import 'package:wallpaperapp/Datas.dart';

class SearchFilter extends StatelessWidget {
  double scrW = 0;
  double scrH = 0;

  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyWallAppDatas>(context, listen: true);

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.01),
                Colors.white.withOpacity(0.1)
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            width: scrW * 0.9,
            height: scrH * 0.8,
            decoration: BoxDecoration(
              color: myDatas.isDarkMode() ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: scrH * 0.02),
                OrientaionSelectWidget(),
                CatagorySelectWidget(),
                MainColorSelectorWidget(),
                SizedBox(height: scrH * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Text("Clear"),
                      onPressed: () {
                        myDatas.setCategory("All");
                        myDatas.setMainColors("All");
                        myDatas.setOrientation("All");
                        ;
                        // myWallAppDatas.displayData();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                        child: Text("Apply"),
                        onPressed: () {
                          //------------afer doing
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
