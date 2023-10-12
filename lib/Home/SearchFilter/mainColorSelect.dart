import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/Datas.dart';

class MainColorSelectorWidget extends StatelessWidget {
  @override
  double scrW = 0;
  double scrH = 0;
  String selItem = "";
  List<List<dynamic>> colorList = [
    ['All', Colors.lightBlue],
    ['Black', Colors.black],
    ['Red', Colors.red],
    ['Blue', Colors.blue],
    ['Pink', Colors.pink],
    ['White', Colors.white],
    ['Brown', Colors.brown],
    ['Orange', Colors.orange],
    ['Green', Colors.green],
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
          labelText: 'Color Theme',
          labelStyle:
              TextStyle(fontSize: scrW * 0.06, fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: myDatas.isDarkMode() ? Colors.white : Colors.black,
                width: 1),
          ),
        ),
        child: Material(
          color: myDatas.isDarkMode() ? Colors.black : Colors.white,
          child: Container(
            height: scrH * 0.2,
            width: scrW * 0.3,
            child: GridView.builder(
              itemCount: colorList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    myDatas.setMainColors(colorList[index][0]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: myDatas.MainColors == colorList[index][0]
                            ? const Color.fromARGB(255, 206, 215, 220)
                            : null),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: scrW * 0.08,
                          decoration: BoxDecoration(
                            color: colorList[index][1],
                            shape: BoxShape.circle,
                          ),
                          child: const Text(" "),
                        ),
                        Text(
                          colorList[index][0],
                          softWrap: true,
                          style: TextStyle(
                              color: myDatas.isDarkMode()
                                  ? Colors.white
                                  : Colors.black),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
