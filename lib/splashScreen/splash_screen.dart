import 'dart:async';
import 'package:drivers_app/authentication/login_screen.dart';
import 'package:drivers_app/authentication/signup_screen.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/mainScreens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySplashScreen extends StatefulWidget
{
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}



class _MySplashScreenState extends State<MySplashScreen>
{

  startTimer()
  {
    Timer(const Duration(seconds: 3), () async
    {
      if(await fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    
    startTimer();
  }
  
  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/driver.png"),
              const SizedBox(height: 10,),
              Text(
                "USM GO",
                style: GoogleFonts.aBeeZee(
                  fontSize: 45,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Your Carpooling App",
                style: GoogleFonts.josefinSans(
                    fontSize: 25,
                    color: Colors.black54,
                    fontStyle: FontStyle.italic
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
