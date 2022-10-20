import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/firebase/firebase_helper.dart';
import 'package:new_project/screens/credits.dart';
import 'package:new_project/screens/map/current_location.dart';

import 'package:new_project/screens/resultpage.dart';
import 'package:new_project/screens/sectors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

var loginUser = FirebaseAuth.instance.currentUser;
Service service = Service();

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseReference dbref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child("User");
  }

  TextEditingController userreqloc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onbackbottonpressed(context),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
                title: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Center(
                      child: Image.asset(
                        'images/frontpage.jpg',
                        height: 100,
                        width: 200,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Color.fromRGBO(26, 11, 66, 1)

                // leading: IconButton(
                //     onPressed: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => LoginPage()));
                //     },
                //     icon: Icon(
                //       Icons.arrow_circle_left_sharp,
                //       size: Dimension.iconSize16 * 3,
                //       color: Color.fromRGBO(28, 11, 67, 0.9),
                //     )),
                // title: Padding(
                //   padding: EdgeInsets.only(
                //       right: Dimension.width20, left: Dimension.width20),
                //   child: TextField(
                //     style: TextStyle(color: Colors.white),
                //     controller: userreqloc,
                //     decoration: InputDecoration(
                //         fillColor: Colors.transparent,
                //         filled: true,
                //         hintText: 'Search Location',
                //         hintStyle: TextStyle(color: Colors.white),
                //         prefixIcon: IconButton(
                //             icon: Icon(
                //               Icons.location_on,
                //               size: 30,
                //               color: Colors.red,
                //             ),
                //             onPressed: () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) => UserCurrentLocation()));
                //             }),
                //         suffixIcon: IconButton(
                //             onPressed: userenteredlocation,
                //             icon: Icon(
                //               Icons.search,
                //               color: Colors.white,
                //             )),
                //         border: OutlineInputBorder(
                //             borderSide: BorderSide(color: Colors.white),
                //             borderRadius:
                //                 BorderRadius.circular(Dimension.radius20))),
                //   ),
                // ),

                //
                ),
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(padding: EdgeInsets.zero, children: [
              UserAccountsDrawerHeader(
                otherAccountsPictures: <Widget>[
                  Icon(
                    Icons.dark_mode_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
                accountName: GestureDetector(
                  child: Text(
                    "Dhinakaran R",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Cinzel',
                        color: Colors.black),
                  ),
                  onTap: () {},
                ),
                accountEmail: Text(
                  "dhina0508@gmail.com",
                  style: TextStyle(color: Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/profile.png'),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 206, 191, 216),
                ),
              ),
              // Divider(
              //   color: Colors.black,
              //   thickness: 1,
              //   height: 0,
              // ),
              Column(
                children: [
                  ListTile(
                      title: Text(
                        'Home',
                        style: TextStyle(fontSize: 20),
                      ),
                      leading: Icon(
                        Icons.home,
                        color: Color.fromARGB(255, 200, 115, 221),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text(
                  'Credits',
                  style: TextStyle(fontSize: 20),
                ),
                leading: Icon(
                  Icons.credit_card,
                  color: Color.fromARGB(255, 200, 115, 221),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Credits()));
                },
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text(
                  'Know Your Drain Info',
                  style: TextStyle(fontSize: 20),
                ),
                leading: Icon(
                  Icons.circle_notifications,
                  color: Color.fromARGB(255, 200, 115, 221),
                ),
                onTap: () {},
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text(
                  'Graph',
                  style: TextStyle(fontSize: 20),
                ),
                leading: Icon(
                  Icons.incomplete_circle_rounded,
                  color: Color.fromARGB(255, 200, 115, 221),
                ),
                onTap: () {},
              ),
              SizedBox(
                height: 15,
              ),

              ListTile(
                title: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 20),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 200, 115, 221),
                ),
                onTap: () async {
                  service.signOut(context);
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.remove("email");
                },
              ),
            ]),
          ),
          body: Stack(children: [
            Image.asset(
              'images/rainy.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Dimension.radius20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(95, 28, 11, 67),
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: Dimension.height50),
                              child: Text(
                                'Select Location to Detect:',
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
                            TextField(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              controller: userreqloc,
                              decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  hintText: 'Enter Location',
                                  // label: Text(
                                  //   'District Name or Area Name',
                                  //   style: TextStyle(
                                  //       color: Colors.white, fontSize: 15),
                                  // ),
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  prefixIcon: IconButton(
                                      icon: Icon(
                                        Icons.my_location_rounded,
                                        size: 23,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {}),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          Dimension.radius20))),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserCurrentLocation()));
                              },
                              child: Container(
                                child: Container(
                                  height: 40,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(146, 81, 37, 104),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 27,
                                          color: Color.fromARGB(
                                              255, 232, 113, 104),
                                        ),
                                        Text(
                                          'Select in Map',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            )
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
                            onPressed: () async {
                              if (userreqloc.text != null) {
                                Map<String, String> User = {
                                  'location': userreqloc.text
                                };
                                dbref.push().set(User);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Sectors()));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(' Please select Location '),
                                  behavior: SnackBarBehavior.fixed,
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: Dimension.height45,
                                width: 150,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: Dimension.height10,
                                      bottom: Dimension.height10,
                                      right: Dimension.width10,
                                      left: Dimension.width15),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Proceed',
                                        style: TextStyle(
                                            fontSize: Dimension.iconSize24,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_right_sharp,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ))))
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontSize: Dimension.font20, fontWeight: FontWeight.bold),
    ));

Future<bool> _onbackbottonpressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('EXIT'),
          content: Text('Do You Want to Close the App?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No')),
          ],
        );
      });
  return exitApp;
}
