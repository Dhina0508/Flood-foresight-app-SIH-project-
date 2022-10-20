import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/screens/homepage.dart';
import 'package:new_project/screens/map/current_location.dart';
import 'package:new_project/screens/resultpage.dart';

class Sectors extends StatefulWidget {
  Sectors({Key? key}) : super(key: key);

  @override
  State<Sectors> createState() => _SectorsState();
}

class _SectorsState extends State<Sectors> {
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
  ];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserCurrentLocation()));
            },
            child: Container(
                height: Dimension.height50,
                decoration: BoxDecoration(
                    //   color: Color.fromRGBO(140, 124, 164, 1),
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
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          snapshot.value.toString(),
                          style: TextStyle(
                              fontSize: Dimension.iconSize24,
                              fontFamily: 'Cinzel',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Spacer(),
                        Spacer()
                      ],
                    );
                  },
                )),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(26, 11, 66, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_circle_left_sharp,
              size: Dimension.iconSize16 * 2.5,
              color: Color.fromARGB(227, 170, 136, 208),
            ),
          ),
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
                            'Select Sector to Detect:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'JosefinSans',
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
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(95, 28, 11, 67),
                        ),
                        onPressed: () {
                          if (value != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(' Please select Sector '),
                              behavior: SnackBarBehavior.fixed,
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ));
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: Dimension.height45,
                            width: Dimension.width45 * 4,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: Dimension.height10,
                                  bottom: Dimension.height10,
                                  right: Dimension.width15,
                                  left: Dimension.width15),
                              child: Row(
                                children: [
                                  Text(
                                    'Show Status',
                                    style: TextStyle(
                                        fontSize: Dimension.iconSize24,
                                        color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                    size: 35,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ))))
              ],
            ),
          ),
        ]));
  }
}
