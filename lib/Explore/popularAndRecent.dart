// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/cardDisplay.dart';
import 'package:wallpaperapp/Datas.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class PopularAndRecent extends StatelessWidget {
  double scrW = 0;
  double scrH = 0;
  String recentOrPopular;
  PopularAndRecent({required this.recentOrPopular});

  var myDatas;

  Future<Map<String, dynamic>> getPhotosList() async {
    String url =
        "https://pixabay.com/api/?key=${myDatas.API_Key}&order=${recentOrPopular}";
    //print(url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Server isn't in the mood");
    }
  }

  @override
  Widget build(BuildContext context) {
    myDatas = Provider.of<MyWallAppDatas>(context, listen: true);

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
                recentOrPopular == "popular"
                    ? "Trending Now"
                    : "Recent Uploads",
                style: GoogleFonts.notoSerifLao(
                  color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                  fontSize: scrW * 0.07,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        FutureBuilder(
          future: getPhotosList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                height: scrH * 0.36,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, mainAxisSpacing: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!['hits'].length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CardDisplay(
                                photoDetails: snapshot.data!['hits'][index]);
                          },
                        );
                      },
                      child: Card(
                        color: Colors.transparent,
                        elevation: 15,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              snapshot.data!['hits'][index]['webformatURL'],
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            )),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                height: scrH * 0.36,
                child: Center(
                  child: Text(
                    "Unable To Load!",
                    style: TextStyle(
                      color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                height: scrH * 0.36,
                child: Center(
                  child: Text(
                    "Loading",
                    style: TextStyle(
                      color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
