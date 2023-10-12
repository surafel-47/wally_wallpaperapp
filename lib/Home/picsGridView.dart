// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/cardDisplay.dart';
import 'package:wallpaperapp/Datas.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PicsGridView extends StatefulWidget {
  const PicsGridView({super.key});

  @override
  State<PicsGridView> createState() => PicsGridViewState();
}

class PicsGridViewState extends State<PicsGridView> {
  double scrW = 0;
  double scrH = 0;
  late Future<Map<String, dynamic>> jsonDataRecived;
  var myDatas;

  @override
  void initState() {
    super.initState();
    jsonDataRecived = getPhotosList();
  }

  Future<Map<String, dynamic>> getPhotosList() async {
    String url =
        "https://pixabay.com/api/?key=${myDatas.API_Key}&q=${myDatas.q.toLowerCase()}&category=${myDatas.Category.toLowerCase()}&colors${myDatas.MainColors.toLowerCase()}&Orientation=${myDatas.Orientation.toLowerCase()}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Server isn't in the mood");
    }
  }

  //to refresh
  void updateState() {
    jsonDataRecived = getPhotosList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    myDatas = Provider.of<MyWallAppDatas>(context, listen: true);
    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: jsonDataRecived,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!['hits'].length == 0) {
            return Center(
              child: Column(
                children: [
                  Lottie.asset("assets/noResults.json", fit: BoxFit.scaleDown),
                  Text(
                    "No Matching Results  :(",
                    style: TextStyle(
                      fontSize: scrW * 0.06,
                      color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox(
            width: scrW * 0.9,
            height: scrH * 0.73,
            child: MasonryGridView.builder(
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              itemCount: snapshot.data!['hits'].length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (context, index) {
                String imgPrviewUrl =
                    snapshot.data!['hits'][index]['previewURL'];
                Map<String, dynamic> photoDetails =
                    snapshot.data!['hits'][index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CardDisplay(photoDetails: photoDetails);
                      },
                    );
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 10,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          child: Image.network(
                            imgPrviewUrl,
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        )),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Pull To Refresh!"),
                duration: Duration(seconds: 5),
              ),
            );
          });
          return RefreshIndicator(
            onRefresh: () async {
              jsonDataRecived = getPhotosList();
              setState(() {});
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SizedBox.fromSize(
                child: Center(
                    child: Column(
                  children: [
                    Lottie.asset("assets/noInternet.json"),
                    Text(
                      "Unable to load Data :(",
                      style:
                          TextStyle(fontSize: scrW * 0.06, color: Colors.black),
                    ),
                  ],
                )),
              ),
            ),
          );
        } else {
          return Container(
            child: Center(
                child: Text(
              "Loading... :)",
              style: TextStyle(fontSize: scrW * 0.06, color: Colors.black),
            )),
          );
        }
      },
    );
  }
}
