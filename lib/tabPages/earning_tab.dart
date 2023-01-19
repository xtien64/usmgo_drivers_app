import 'package:drivers_app/assistants/assistant_methods.dart';
import 'package:drivers_app/infoHandler/app_info.dart';
import 'package:drivers_app/mainScreens/trips_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class EarningsTabPage extends StatefulWidget {
  const EarningsTabPage({Key? key}) : super(key: key);

  @override
  _EarningsTabPageState createState() => _EarningsTabPageState();
}

class _EarningsTabPageState extends State<EarningsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [

          //earnings
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [

                  Text(
                    "Your Earnings:",
                    style: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Text(
                    "RM " + Provider.of<AppInfo>(context, listen: false).driverTotalEarnings,
                    style: GoogleFonts.aBeeZee(
                      color: Colors.black54,
                      fontSize: 40,
                      fontStyle: FontStyle.italic
                    ),
                  ),

                ],
              ),
            ),
          ),

          //total number of trips
          ElevatedButton(
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c)=> TripsHistoryScreen()));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white54
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [

                    Image.asset(
                      "images/car_logo.png",
                      width: 100,
                    ),

                    const SizedBox(
                      width: 6,
                    ),

                    Text(
                      "Trips Completed",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    Expanded(
                      child: Container(
                        child: Text(
                          Provider.of<AppInfo>(context, listen: false).allTripsHistoryInformationList.length.toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
