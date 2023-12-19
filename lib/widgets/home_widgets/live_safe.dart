import 'package:flutter/material.dart';

import 'live_safe/BusStationCard.dart';
import 'live_safe/HospitalCard.dart';
import 'live_safe/PharmacyCard.dart';
import 'live_safe/PoliceStationCard.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width:MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceStationCard(),
          HospitalCard(),
          PharmacyCard(),
          BusStationCard(),

        ],
      ),
    );
  }
}
