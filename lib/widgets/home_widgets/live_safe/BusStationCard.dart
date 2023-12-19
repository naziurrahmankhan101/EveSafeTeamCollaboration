import 'package:flutter/material.dart';

class BusStationCard extends StatelessWidget {
  const BusStationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 57,
              width: 57,
              child:Center(
                child: Image.asset(
                  'assets/BusStop.jpg',
                  height: 30,
                ),
              ),
            ),
          ),
          Text('BusStop',
            style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
