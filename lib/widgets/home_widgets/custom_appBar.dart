
import 'package:flutter/material.dart';
import 'package:after_marjana/utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
  //const CustomAppBar({super.key});
  Function? onTap;
  int? quoteIndex;
  CustomAppBar({this.onTap , this.quoteIndex});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
        onTap!();
      } ,
      child: Container(
        child: Text(
          sweetSayings[quoteIndex!],
          style: TextStyle(
            fontSize: 25,
            color: Colors.black, // Set your desired text color here
            // You can use other properties of TextStyle to further customize the text style if needed
          ),
        ),
      ),
    );
  }
}

