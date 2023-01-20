import 'package:drivers_app/authentication/car_info_screen.dart';
import 'package:drivers_app/authentication/terms_of_use.dart';
import 'package:flutter/gestures.dart';
import 'package:drivers_app/authentication/login_screen.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dialog/policy_dialog.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController password2TextEditingController =
      TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be at least 3 Characters.");
    } else if (!emailTextEditingController.text.contains("@student.usm.my") &&
        !emailTextEditingController.text.contains("@usm.my")) {
      //else if (!(EmailValidator.validate(emailTextEditingController.text))) {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number is required.");
    } else if (!RegExp(
            r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
        .hasMatch(phoneTextEditingController.text)) {
      Fluttertoast.showToast(msg: "Phone Number is invalid.");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be at least 6 Characters.");
    } else if (password2TextEditingController.text !=
        passwordTextEditingController.text) {
      Fluttertoast.showToast(msg: "Password does not match.");
    } else {
      saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing, Please wait...",
          );
        });

    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      Map driverMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => CarInfoScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/driver.jpg"),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Register as a Driver",
                style: GoogleFonts.josefinSans(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  hintText: "Full Name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "USM email (eg.: xxx@student.usm.my / xxx@usm.my)",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password (at least 6 characters)",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: password2TextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Re- Enter Password",
                  hintText: "Password (at least 6 characters)",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),

              TextButton(
                child: const Text(
                  " Already have account? LOGIN HERE",
                  style: TextStyle(color: Colors.black54),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => LoginScreen()));
                },
              ),

              // TermsOfUse()
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
                  child: Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'By continuing, you agree to our ',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Terms of Service',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (_) => MyHomePage()));
                                        // code to open / launch terms of service link here
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return PolicyDialog(
                                              mdFileName:
                                                  'terms_and_conditions.md',
                                            );
                                          },
                                        );
                                      }),
                                TextSpan(
                                    text: ' and ',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              decoration:
                                                  TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // code to open / launch privacy policy link here
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return PolicyDialog(
                                                    mdFileName:
                                                        'privacy_policy.md',
                                                  );
                                                },
                                              );
                                            })
                                    ])
                              ]))))
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get smallHeightSpacing => SizedBox(height: 12);
}
