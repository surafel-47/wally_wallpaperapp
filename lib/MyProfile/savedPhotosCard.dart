// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/cardDisplay.dart';
import 'package:wallpaperapp/Datas.dart';

class SavedPhotosCard extends StatelessWidget {
  SavedPhotosCard({required this.photoData});

  Map<String, dynamic> photoData;
  double scrW = 0;
  double scrH = 0;
  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyWallAppDatas>(context, listen: true);

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return CardDisplay(
              photoDetails: photoData,
            );
          },
        );
      },
      child: Container(
        height: scrH * 0.30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
              photoData['webformatURL'],
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Card(
          elevation: 5,
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.8)
                  ],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      myDatas.removeImgFromLiked(photoData: photoData);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: scrW * 0.09,
                    ),
                  ),
                  Icon(Icons.circle, color: Colors.white, size: scrW * 0.02),
                  SizedBox(width: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        formatImgName(photoData['tags']),
                        style: TextStyle(
                          fontSize: scrW * 0.05,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatImgName(String input) {
    if (input.isEmpty) {
      return '';
    }

    List<String> words = input.split(',').map((s) => s.trim()).toList();

    if (words.isEmpty) {
      return '';
    }

    if (words.length == 1) {
      return '${words[0][0].toUpperCase()}${words[0].substring(1)}';
    }

    return '${words[0][0].toUpperCase()}${words[0].substring(1)} ${words[1][0].toUpperCase()}${words[1].substring(1)}';
  }
}
