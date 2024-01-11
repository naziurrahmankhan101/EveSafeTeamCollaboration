import 'package:flutter/material.dart';

class SafeHome extends StatelessWidget {
  const SafeHome({super.key});
  showModelSafeHome(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder:(context){
        return Container(
            height: MediaQuery.of(context).size.height/1.4,
            color: Colors.redAccent,
        );
      },

    );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>showModelSafeHome(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width*0.7,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Send Location",
                      style: TextStyle(
                        color: Colors.white, // Set text color to white
                        fontSize: 28, // Set font size
                        fontWeight: FontWeight.bold, // Make text bold
                      ),
                    ),
                    subtitle: Text(
                      "Share Location",
                      style: TextStyle(
                        color: Colors.white, // Set text color to white
                        fontSize: 17, // Set font size
                        fontWeight: FontWeight.bold, // Make text bold
                      ),
                    ),
                  )
                ],
              )),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Transform.scale(
                  scale: 0.75, // Set your desired scale value
                  child: Image.asset('assets/send.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
