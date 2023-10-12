// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/Datas.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class CardDisplay extends StatefulWidget {
  Map<String, dynamic> photoDetails;
  CardDisplay({required this.photoDetails});
  @override
  State<CardDisplay> createState() => _CardDisplayState();
}

class _CardDisplayState extends State<CardDisplay> {
  @override
  void initState() {
    super.initState();
    quoteOfTheDay = randomQuoteGenertor();
  }

  late Future<dynamic> quoteOfTheDay;

  double scrW = 0;
  double scrH = 0;

  bool isBottomBarHidden = false;

  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyWallAppDatas>(context, listen: true);

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;

    return Material(
      child: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 13, 8, 31),
          ),
          GestureDetector(
            onTap: () {
              isBottomBarHidden = !isBottomBarHidden;
              setState(() {});
            },
            child: Center(
              child: PhotoView(
                minScale: PhotoViewComputedScale.contained * 1,
                imageProvider: NetworkImage(
                  widget.photoDetails['largeImageURL'],
                ),
              ),
            ),
          ),
          isBottomBarHidden ? Container() : BottomBar(myDatas: myDatas),
        ],
      ),
    );
  }

  Widget BottomBar({required MyWallAppDatas myDatas}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          height: scrH * 0.27,
          width: scrW,
          padding: EdgeInsets.only(bottom: 35, right: 10),
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
          //----------------Starts Here--------------------------------------------------//
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  // color: Colors.yellow,
                  height: scrH * 0.25,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            IconButton(
                              iconSize: scrW * 0.09,
                              onPressed: () async {
                                if (myDatas.isPhotoLiked(widget.photoDetails)) {
                                  myDatas.removeImgFromLiked(
                                      photoData: widget.photoDetails);
                                } else {
                                  myDatas.addImgToLiked(
                                      photoData: widget.photoDetails);
                                }
                              },
                              icon: myDatas.isPhotoLiked(widget.photoDetails)
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.heart_broken,
                                      color: Colors.white,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.circle,
                                  color: Colors.white, size: 6),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  formatImgName(widget.photoDetails['tags']),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrW * 0.07),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: FutureBuilder(
                              future: quoteOfTheDay,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      Text(
                                        "\"${snapshot.data!["quoteText"]}\" \n",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          snapshot.data!["quoteAuthor"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Text("");
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  //color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () async {
                            Directory? directory =
                                await getExternalStorageDirectory();
                            String savedDir =
                                '${directory!.path}/Download/WefWallpaper';

                            final taskId = await FlutterDownloader.enqueue(
                              url: widget.photoDetails['largeImageURL'],
                              savedDir: savedDir,
                              fileName:
                                  formatImgName(widget.photoDetails['tags']),
                              showNotification: true,
                              openFileFromNotification: true,
                            );
                          },
                          icon: Icon(
                            Icons.download,
                            color: Colors.white,
                            size: scrW * 0.1,
                          )),
                      IconButton(
                          onPressed: () {
                            Share.share(widget.photoDetails['previewURL']);
                            print("Clikjedd");
                          },
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: scrW * 0.1,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.wallpaper,
                            color: Colors.white,
                            size: scrW * 0.1,
                          )),
                    ],
                  ),
                ),
              )
            ],
          )),
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

  Future<dynamic> randomQuoteGenertor() async {
    String apiUrl =
        "http://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en";
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return "";
    }
  }
}
