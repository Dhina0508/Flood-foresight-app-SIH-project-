import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/screens/homepage.dart';
import 'package:new_project/screens/otp.dart';

import 'package:pinput/pinput.dart';

class ForgotPage extends StatefulWidget {
  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  String dialCodeDigits = "+00";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      ),
      body: Stack(children: [
        Image.asset(
          'images/rain.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "OTP Authentication",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'JosefinSans'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello, Welcome Back to our App!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Icon(Icons.hail_rounded)
              ],
            ),
            SizedBox(
              height: Dimension.height75,
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 31, 13, 74),
                  Color.fromRGBO(205, 189, 223, 1),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Select Country Code',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 248, 248, 248),
                    ),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: CountryCodePicker(
                      onChanged: (country) {
                        setState(() {
                          dialCodeDigits = country.dialCode!;
                        });
                      },
                      initialSelection: "IN",
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      favorite: [
                        "+91",
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimension.height45,
                  ),
                  Text(
                    "Enter Mobile Number",
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.call,
                            color: Colors.green,
                          ),
                          border: OutlineInputBorder(
                              //borderSide: BorderSide(),
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius20)),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Phone Number",
                          prefix: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(dialCodeDigits),
                          )),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: _controller,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dimension.height50,
            ),
            Container(
                margin: EdgeInsets.all(15),
                width: Dimension.width50 * 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 112, 54, 146)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpPage(
                                  phone: _controller.text,
                                  codeDigits: dialCodeDigits)));
                    },
                    child: Text('Request OTP'),
                  ),
                ))
          ],
        )),
      ]),
    );
  }
}
