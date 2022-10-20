import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/firebase/firebase_helper.dart';
import 'package:new_project/screens/homepage.dart';

class ChangePass extends StatefulWidget {
  ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Service service = Service();
  @override
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_circle_left_sharp,
            size: Dimension.iconSize50,
            color: Color.fromRGBO(28, 11, 67, 0.9),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/rain.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'Welcome Back ',
                  style: TextStyle(
                      fontSize: 35, color: Colors.white, fontFamily: 'Cinzel'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: Dimension.height75 * 4,
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 31, 13, 74),
                    Color.fromRGBO(205, 189, 223, 1),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Enter Login Id',
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            prefixIcon: Icon(
                              Icons.person_add,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, right: 20, left: 20),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Enter New Password',
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.lock_rounded,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, right: 20, left: 20),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: confirmpasswordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.lock_rounded,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 40,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 104, 37, 118)),
                        onPressed: () {
                          if (passwordcontroller.text ==
                              confirmpasswordcontroller.text) {
                            currentUser!
                                .updatePassword(confirmpasswordcontroller.text)
                                .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage())))
                                .onError((error, stackTrace) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("ERROR ${error.toString()}"),
                                behavior: SnackBarBehavior.floating,
                              ));
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Passwords should be same"),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        )),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
