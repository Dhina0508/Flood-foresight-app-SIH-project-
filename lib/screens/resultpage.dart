import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/screens/homepage.dart';

import '../firebase/firebase_helper.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final auth = FirebaseAuth.instance;
  Service service = Service();
  var loginUser = FirebaseAuth.instance.currentUser;

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final number = "01126701700";
    final flood = FirebaseDatabase.instance.ref().child("Data");
    final loc = FirebaseDatabase.instance.ref().child("location");
    final drain = FirebaseDatabase.instance.ref().child("drain_level");
    final weather = FirebaseDatabase.instance.ref().child("weather");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(
              Icons.arrow_circle_left_sharp,
              size: Dimension.iconSize50,
              color: Color.fromRGBO(28, 11, 67, 0.9),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Dimension.width10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(28, 11, 67, 0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    onPressed: () async {
                      service.signOut(context);
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.remove("email");
                    },
                    icon: Icon(
                      Icons.logout,
                      size: Dimension.iconSize24,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Stack(children: [
          Image.asset(
            'images/rainy.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Dimension.radius20 / 2),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black54, width: 3),
                      borderRadius: BorderRadius.circular(Dimension.radius15),
                    ),
                    elevation: 5,
                    shadowColor: Color.fromARGB(255, 116, 15, 211),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(28, 11, 67, 1),
                              Color.fromRGBO(205, 189, 223, 1),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      width: Dimension.width50 * 6,
                      child: FirebaseAnimatedList(
                          shrinkWrap: true,
                          query: loc,
                          itemBuilder: (context, snapshot, animation, index) {
                            return Padding(
                              padding: EdgeInsets.all(Dimension.height10),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Spacer(),
                                    Icon(
                                      Icons.location_on_sharp,
                                      color: Colors.red,
                                      size: Dimension.iconSize16 * 2,
                                    ),
                                    Text(
                                      snapshot.value.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimension.font26),
                                    ),
                                    Spacer()
                                  ]),
                            );
                          }),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimension.height75,
              ),
              Padding(
                padding: EdgeInsets.all(Dimension.height10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(95, 28, 11, 67),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Dimension.height30,
                        bottom: Dimension.height30,
                        left: Dimension.width30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                              top: Dimension.height10 / 2,
                              bottom: 10,
                            ),
                            child: FirebaseAnimatedList(
                                shrinkWrap: true,
                                query: drain,
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return Row(
                                    children: [
                                      Text(
                                        "Drainage Level: ",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 221, 178, 178),
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimension.font20),
                                      ),
                                      Text(
                                        snapshot.value.toString() + " Inches",
                                        style: TextStyle(
                                            fontSize: Dimension.font20,
                                            color: Colors.white),
                                      )
                                    ],
                                  );
                                })),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimension.height10,
                              bottom: Dimension.height10),
                          child: FirebaseAnimatedList(
                              shrinkWrap: true,
                              query: weather,
                              itemBuilder:
                                  (context, snapshot, animation, index) {
                                return Row(
                                  children: [
                                    Text(
                                      'Weather: ',
                                      style: TextStyle(
                                          fontSize: Dimension.font20,
                                          color: Color.fromARGB(
                                              255, 221, 178, 178),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.value.toString(),
                                      style: TextStyle(
                                          fontSize: Dimension.font20,
                                          color: Colors.white),
                                    )
                                  ],
                                );
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimension.height10,
                              bottom: Dimension.height10 / 2),
                          child: FirebaseAnimatedList(
                              shrinkWrap: true,
                              query: flood,
                              itemBuilder:
                                  (context, snapshot, animation, index) {
                                return Row(
                                  children: [
                                    Text(
                                      'Prediction: ',
                                      style: TextStyle(
                                        fontSize: Dimension.font20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 221, 178, 178),
                                      ),
                                    ),
                                    Text(
                                      snapshot.value.toString(),
                                      style: TextStyle(
                                          fontSize: Dimension.font20,
                                          color: Colors.white),
                                    )
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(Dimension.font16 / 2),
                child: ElevatedButton(
                  onPressed: () {
                    launch('tel://$number');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Helpline",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Dimension.font16, color: Colors.white)),
                      SizedBox(
                        width: Dimension.width10,
                      ),
                    ],
                  ),
                 // color: Color.fromRGBO(28, 11, 67, 0.9),
                ),
              ),
              SizedBox(
                height: Dimension.height50,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
