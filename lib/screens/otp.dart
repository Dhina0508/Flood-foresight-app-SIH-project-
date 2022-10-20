import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/screens/change_password.dart';
import 'package:new_project/screens/forgot.dart';
import 'package:new_project/screens/map/current_location.dart';
import 'package:new_project/screens/homepage.dart';
import 'package:new_project/screens/loginpage.dart';
import 'package:new_project/screens/resultpage.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final String phone;
  final String codeDigits;

  OtpPage({required this.phone, required this.codeDigits});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinotpcontroller = TextEditingController();
  final FocusNode _pinotpfocusnode = FocusNode();
  String? VerificationCode;

  final BoxDecoration pinotpdecoration = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhonenumber();
  }

  verifyPhonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.codeDigits + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangePass()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ));
        },
        codeSent: (String vID, int? resentToken) {
          setState(() {
            VerificationCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID) {
          setState(() {
            VerificationCode = vID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffolkey,
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
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'OTP Verification',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Cinzel',
                fontSize: 22,
                fontWeight: FontWeight.bold),
          )),
      body: Stack(children: [
        Image.asset(
          'images/rain.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'images/otp.jpg',
            width: double.infinity,
            height: 270,
          ),
          SizedBox(
            height: Dimension.height75,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  verifyPhonenumber();
                },
                child: Text(
                  "Verifying: ${widget.codeDigits} ${widget.phone}",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(30),
              child: Pinput(
                length: 6,
                focusNode: _pinotpfocusnode,
                controller: _pinotpcontroller,
                pinAnimationType: PinAnimationType.fade,
                closeKeyboardWhenCompleted: false,
                onSubmitted: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: VerificationCode!, smsCode: pin))
                        .then((value) {
                      if (value.user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePass()));
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid OTP"),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                  }
                },
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(234, 239, 243, 1), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 300,
            height: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Verify",
                  style: TextStyle(fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(28, 11, 67, 0.9)),
              ),
            ),
          )
        ]),
      ]),
    );
  }
}
