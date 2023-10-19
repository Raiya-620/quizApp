
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
     backgroundColor: Colors.black,
     body: Center(
      child: Stack(
        children: [
          SafeArea(
            child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 35,
                  decoration:  BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color:Colors.white,width:3),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context,constraints)=>Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)
                          ),
                        )
                        )
                    ],
                  ),
                )
              ],
            ),
            )
            )
        ],
      ),
     ),
    );
  }
}