// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, camel_case_types
import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyWallAppDatas extends ChangeNotifier {
  String API_Key = "34335834-212f4976c3b0c2e30561ce930";
  String Category = "All";
  String MainColors = "All";
  String Orientation = "All"; // all, horizontal, vertical
  String q = ""; //this is the search Query
  List<Map<String, dynamic>> LikedImgs = [];

  void setQuery(String val) {
    q = val;
    notifyListeners();
  }

  void removeImgFromLiked({required Map<String, dynamic> photoData}) {
    LikedImgs.remove(photoData);
    saveLikedPhotosFromList();
    notifyListeners();
  }

  void addImgToLiked({required Map<String, dynamic> photoData}) {
    LikedImgs.add(photoData);
    saveLikedPhotosFromList();
    notifyListeners();
  }

  void setCategory(String val) {
    Category = val;
    notifyListeners();
  }

  void setMainColors(String val) {
    MainColors = val;
    notifyListeners();
  }

  void setOrientation(String val) {
    Orientation = val;
    notifyListeners();
  }

  int getOrientionIndex() {
    if (Orientation == "All") {
      return 1;
    } else if (Orientation == "Vertical") {
      return 2;
    } else {
      return 3;
    }
  }

  bool isPhotoLiked(Map<String, dynamic> val) {
    if (LikedImgs.contains(val)) {
      return true;
    } else {
      return false;
    }
  }

  void setDarkMode(bool val) {
    darkMode = val;
    notifyListeners();
  }

  bool darkMode = false;
  bool isDarkMode() {
    return darkMode;
  }

  Future<void> loadLikedPhotosToList() async {
    // final localPath = await getApplicationDocumentsDirectory();
    // File likedFile = File("${localPath.path}/likedPhotos.txt");
    // if (!await likedFile.exists()) {
    //   await likedFile.create();
    //   return;
    // } else {
    //   String fileContent = likedFile.readAsStringSync();
    //   final decodedData = jsonDecode(fileContent);
    //   LikedImgs = List<Map<String, dynamic>>.from(
    //       decodedData.map((item) => Map<String, dynamic>.from(item)));
    // }
  }

  Future<void> saveLikedPhotosFromList() async {
    // final localPath = await getApplicationDocumentsDirectory();
    // File likedFile = File("${localPath.path}/likedPhotos.txt");
    // if (!await likedFile.exists()) {
    //   await likedFile.create();
    // }
    // String fileContent = jsonEncode(LikedImgs);
    // likedFile.writeAsStringSync(fileContent);
  }

  void displayData() {
    print("API Key: $API_Key");
    print("Orientation: $Orientation");
    print("Category: $Category");
    print("Colors: $MainColors");
    print("Search Query: $q");
  }
}
