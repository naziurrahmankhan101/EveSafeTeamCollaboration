import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final Function? onMapFunction;
  const HospitalCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              onMapFunction!('Hospitals+near+me');
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),

              ),
              child: Container(
                height: 57,
                width: 57,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.shade300, // Set your desired background color here
                ),
                child:Center(
                  child: Image.asset(
                    'assets/hospital.png',
                    height: 30,
                  ),
                ),
              ),
            ),
          ),
          Text('Hospitals',
            style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
