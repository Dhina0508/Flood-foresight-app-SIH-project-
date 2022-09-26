import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/screens/forgot.dart';
import 'package:new_project/screens/map/current_location.dart';
import 'package:new_project/screens/homepage.dart';
import 'package:new_project/screens/loginpage.dart';
import 'package:new_project/screens/resultpage.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final String phone;
  OtpPage(this.phone);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        key: _scaffoldkey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ForgotPage()));
              },
              icon: Icon(
                Icons.arrow_circle_left_rounded,
                size: Dimension.iconSize16 * 3,
                color: Color.fromRGBO(205, 189, 223, 1),
              )),
          title: Text(
            'OTP Verification',
            style: TextStyle(color: Colors.white, fontSize: Dimension.font26),
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Image.asset(
            'images/rain.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimension.height30 * 4,
                ),
                Container(
                    height: Dimension.height50 * 5,
                    width: Dimension.width50 * 7,
                    child: Image.asset('images/otp.jpg')),
                SizedBox(
                  height: Dimension.height45,
                ),

                //  Image.asset('images/otp.jpg'),
                Text(
                  'Verification Code',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimension.font30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                Text(
                  'We have sent the code verification to',
                  style: TextStyle(
                    fontSize: Dimension.font16,
                    color: Color.fromARGB(255, 188, 134, 197),
                  ),
                ),
                Text(
                  'your mobile number',
                  style: TextStyle(
                    fontSize: Dimension.font16,
                    color: Color.fromARGB(255, 188, 134, 197),
                  ),
                ),
                SizedBox(
                  height: Dimension.height45,
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: Dimension.height20,
                      left: Dimension.width30,
                      right: Dimension.width30),
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: PinTheme(
                      width: Dimension.width45 + 10,
                      height: Dimension.height45 + 10,
                      textStyle: TextStyle(
                          fontSize: Dimension.font20,
                          color: Color.fromRGBO(30, 60, 87, 1),
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(234, 239, 243, 1), width: 2),
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                      ),
                    ),
                    controller: _pinPutController,
                    pinAnimationType: PinAnimationType.fade,
                    onSubmitted: (pin) async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode!,
                                smsCode: pin))
                            .then((value) async {
                          if (value.user != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserCurrentLocation()),
                                (route) => false);
                          }
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimension.height20 * 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                    child: ElevatedButton(
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(30)),
                      // padding: EdgeInsets.all(0.0),
                      onPressed: () {},
                      child: Container(
                        height: Dimension.height50,
                        width: Dimension.width50 * 6,
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserCurrentLocation()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
