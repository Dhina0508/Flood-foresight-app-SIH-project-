import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/screens/loginpage.dart';
import 'package:new_project/screens/otp.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(
                Icons.arrow_circle_left_rounded,
                size: Dimension.iconSize16 * 3,
                color: Color.fromRGBO(205, 189, 223, 1),
              )),
        ),
        body: Stack(children: [
          Image.asset(
            'images/rain.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: Dimension.height50 * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Login Account',
                    style: TextStyle(
                      fontSize: Dimension.font40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(205, 189, 223, 1),
                    ),
                  ),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  Text(
                    'Hello,Welcome back to our app!',
                    style: TextStyle(
                        color: Colors.grey, fontSize: Dimension.font16),
                  ),
                  SizedBox(
                    height: Dimension.height50 * 4,
                  ),
                  Text(
                    'Enter Mobile Number:',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimension.font12 * 2),
                  ),
                  SizedBox(
                    height: Dimension.height15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Dimension.width30,
                      right: Dimension.width30,
                    ),
                    child: TextField(
                        style: TextStyle(
                            color: Colors.white, fontSize: Dimension.font20),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        controller: _controller,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              '+91',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          // prefix: Text(''),
                          suffixIcon: Icon(
                            Icons.phone_forwarded_rounded,
                            color: Color.fromARGB(255, 201, 106, 217),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(width: 3, color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(width: 3, color: Colors.white),
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        // color: Color.fromARGB(255, 153, 54, 245),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(30)),
                        // padding: EdgeInsets.all(0.0),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OtpPage(_controller.text)));
                        },
                        child: Container(
                          height: Dimension.height50,
                          width: Dimension.width50 * 6,
                          child: Center(
                            child: Text(
                              'Request OTP',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
