import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/Datas.dart';

class OrientaionSelectWidget extends StatelessWidget {
  double scrW = 0;
  double scrH = 0;

  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyWallAppDatas>(context, listen: true);

    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return Container(
      width: scrW * 0.8,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Orientation',
          labelStyle: TextStyle(
            fontSize: scrW * 0.06,
            fontWeight: FontWeight.bold,
            color: myDatas.isDarkMode() ? Colors.white : Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                width: 1),
          ),
        ),
        child: Material(
          color: myDatas.isDarkMode() ? Colors.black : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Radio(
                    value: 1,
                    groupValue: myDatas.getOrientionIndex(),
                    onChanged: (value) {
                      myDatas.setOrientation("All");
                    },
                  ),
                  Icon(Icons.all_inbox,
                      color:
                          myDatas.isDarkMode() ? Colors.white : Colors.black),
                ],
              ),
              Column(
                children: [
                  Radio(
                    value: 2,
                    groupValue: myDatas.getOrientionIndex(),
                    onChanged: (value) {
                      myDatas.setOrientation("Vertical");
                    },
                  ),
                  Icon(Icons.portrait_rounded,
                      color:
                          myDatas.isDarkMode() ? Colors.white : Colors.black),
                ],
              ),
              Column(
                children: [
                  Radio(
                    value: 3,
                    groupValue: myDatas.getOrientionIndex(),
                    onChanged: (value) {
                      myDatas.setOrientation("Horizontal");
                    },
                  ),
                  Icon(Icons.landscape_outlined,
                      color:
                          myDatas.isDarkMode() ? Colors.white : Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
