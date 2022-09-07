import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/screens/loginpage.dart';

import 'package:new_project/screens/resultpage.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final loc = FirebaseDatabase.instance.ref().child("location");
  final sectors = [
    'Sector 1',
    'Sector 2',
    'Sector 3',
    'Sector 4',
    'Sector 5',
    'Sector 6',
    'Sector 7',
    'Sector 8',
    'Sector 9',
    'Sector 10',
    'Sector 11'
  ];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(
                Icons.arrow_circle_left_sharp,
                size: Dimension.iconSize16 * 3,
                color: Color.fromRGBO(28, 11, 67, 0.9),
              )),
          title: Container(
              height: Dimension.height50,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(140, 124, 164, 1),
                  borderRadius: BorderRadius.circular(Dimension.radius20)),
              padding: EdgeInsets.only(
                  top: Dimension.height10,
                  left: Dimension.width15,
                  bottom: Dimension.height10,
                  right: Dimension.width15),
              child: FirebaseAnimatedList(
                query: loc,
                itemBuilder: (context, snapshot, animation, index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Spacer(),
                      Icon(
                        Icons.location_pin,
                        size: Dimension.iconSize16 * 2,
                        color: Colors.red,
                      ),
                      Text(
                        snapshot.value.toString(),
                        style: TextStyle(
                            fontSize: Dimension.iconSize24,
                            fontFamily: 'JosefinSans',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer()
                    ],
                  );
                },
              )),
          centerTitle: true,
        ),
        body: Stack(children: [
          Image.asset(
            'images/rainy.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(Dimension.radius20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(95, 28, 11, 67),
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: Dimension.height50),
                          child: Text(
                            'Select Sector to detect:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Cinzel',
                                fontSize: Dimension.font30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: Dimension.height20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimension.height50),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            margin: EdgeInsets.all(Dimension.height15),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimension.radius20),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  dropdownColor: Color.fromRGBO(28, 11, 67, 1),
                                  hint: Text(
                                    'Select Area',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  value: value,
                                  style: TextStyle(color: Colors.white),
                                  iconSize: Dimension.iconSize16 * 2,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  isExpanded: true,
                                  items: sectors.map(buildMenuItem).toList(),
                                  onChanged: (value) => setState(() {
                                        this.value = value;
                                      })),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimension.height75,
                ),
                ElevatedButton(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(Dimension.radius30)),
                  // padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    setState(() {});
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ResultPage()));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: Dimension.height50,
                      width: Dimension.width45 * 4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(28, 11, 67, 0.8),
                        borderRadius: BorderRadius.circular(Dimension.radius15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimension.height10,
                            bottom: Dimension.height10,
                            right: Dimension.width15,
                            left: Dimension.width15),
                        child: Text(
                          'Show Status',
                          style: TextStyle(
                              fontSize: Dimension.iconSize24,
                              color: Colors.white),
                        ),
                      )),
                )
              ],
            ),
          ),
        ]));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style:
            TextStyle(fontSize: Dimension.font20, fontWeight: FontWeight.bold),
      ));
}
