import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../infoHandler/app_info.dart';
import '../widgets/history_design_ui.dart';


class TripsHistoryScreen extends StatefulWidget
{
  @override
  State<TripsHistoryScreen> createState() => _TripsHistoryScreenState();
}




class _TripsHistoryScreenState extends State<TripsHistoryScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Trips History",
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: ()
          {
            SystemNavigator.pop();
          },
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, i)=> const Divider(
          color: Colors.grey,
          thickness: 2,
          height: 2,
        ),
        itemBuilder: (context, i)
        {
          return Card(
            color: Colors.white54,
            child: HistoryDesignUIWidget(
              tripsHistoryModel: Provider.of<AppInfo>(context, listen: false).allTripsHistoryInformationList[i],
            ),
          );
        },
        itemCount: Provider.of<AppInfo>(context, listen: false).allTripsHistoryInformationList.length,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
