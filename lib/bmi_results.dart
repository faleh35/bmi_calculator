import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMIResults extends StatelessWidget {
  final double result;
  final int height;
  final int weight;
  final int age;
  final bool isMale;



  BMIResults(
    this.age,
    this.height,
    this.weight,
    this.result,
    this.isMale,
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        elevation: 0,
        title: Text("Results",style:TextStyle(
          color: Colors.grey
        ),),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Result: ${result.round()}",style: TextStyle(
              fontSize: 25,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),),
            Text("Age: $age",style: TextStyle(
              fontSize: 25,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),),
            Text("Height: $height",style: TextStyle(
              fontSize: 25,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),),
            Text("Weight: $weight",style: TextStyle(
              fontSize: 25,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),),
            Text("Gendre: ${isMale ? "Male" : "Female"}",style: TextStyle(
              fontSize: 25,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),),


          ],
        ),
      ),
    );
  }
}
