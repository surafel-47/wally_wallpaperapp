// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/MyProfile/savedPhotosCard.dart';
import 'profileTopBar.dart';
import 'package:wallpaperapp/Datas.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatelessWidget {
  double scrW = 0;
  double scrH = 0;

  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyWallAppDatas>(context, listen: true);

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          ProfileTopBar(),
          SizedBox(height: scrH * 0.03),
          SizedBox(
            height: scrH * 0.75,
            width: scrW * 0.95,
            child: myDatas.LikedImgs.length > 0
                ? GridView.builder(
                    itemCount: myDatas.LikedImgs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, mainAxisSpacing: 15),
                    itemBuilder: (context, index) {
                      return SavedPhotosCard(
                        photoData: myDatas.LikedImgs[index],
                      );
                    },
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      myDatas.loadLikedPhotosToList();
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: SizedBox.fromSize(
                        child: Center(
                            child: Column(
                          children: [
                            Lottie.asset("assets/noResults.json",
                                height: scrH * 0.3),
                            SizedBox(height: scrH * 0.04),
                            Text(
                              "Unable to Find Any :(",
                              style: TextStyle(
                                  fontSize: scrW * 0.06,
                                  color: myDatas.isDarkMode()
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
          )
          //  } else if (snapshot.hasError) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text("Pull To Refresh!"),
          //       duration: Duration(seconds: 5),
          //     ),
          //   );
          // });
          // return RefreshIndicator(
          //   onRefresh: () async {
          //     jsonDataRecived = getPhotosList();
          //     setState(() {});
          //   },
          //   child: SingleChildScrollView(
          //     physics: AlwaysScrollableScrollPhysics(),
          //     child: SizedBox.fromSize(
          //       child: Center(
          //           child: Column(
          //         children: [
          //           Lottie.asset("assets/noInternet.json"),
          //           Text(
          //             "Unable to load Data :(",
          //             style: TextStyle(
          //                 fontSize: scrW * 0.06, color: Colors.black),
          //           ),
          //         ],
          //       )),
          //     ),
          //   ),
          // );

/////////////////////////////////////////////////////////////////////////////

          // return Center(
          //   child: Text("Loading..."),
          // );
        ],
      ),
    );
  }
}
