import 'dart:math';
import 'dart:ui';
import 'package:bmi_calcuator/bmi_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';


class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int userHeight = 150;
  int age = 15;
  int weight = 50;
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900] ,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        centerTitle:true,
        elevation: 0,
        title: Text( "BMI Calculator",style: TextStyle(color: Colors.grey),),
      ),
      body:
        Column(
          children: [
            Expanded(
                child:
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isMale = true;
                            });
                          },
                          child:
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isMale ? Colors.blue: Colors.grey ,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.male,size: 100,),
                                Text("Male",style: TextStyle(fontSize: 25),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isMale = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: !isMale ? Colors.blue: Colors.grey

                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.female,size: 100,),
                                Text("Female",style: TextStyle(fontSize: 25),)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("HEIGHT",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text("$userHeight ",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                          Text("CM",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Slider(
                          value: userHeight.toDouble(),
                          activeColor: Colors.black54,
                          thumbColor: Colors.blueGrey,
                          onChanged: (double userCurrentHeight){
                            setState(() {
                              userHeight = userCurrentHeight.round();
                            });
                          },
                        min: 150,
                        max: 220,
                      )
                    ],
                    ),
                  ),
                )
            ),
            Expanded(
              child:
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("AGE",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            Text("$age",style: TextStyle(fontSize: 25),),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FloatingActionButton(
                                    onPressed: (){
                                      setState(() {
                                        if (age <= 10){
                                          Fluttertoast.showToast(
                                              msg: "Check Doctor",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 25.0
                                          );

                                        }else {
                                          age--;
                                        }
                                      });

                                    },
                                  heroTag: "age-",
                                  mini: true,
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.grey,
                                  ),

                                ),
                                SizedBox(width: 10,),
                                FloatingActionButton(
                                    onPressed: (){
                                      setState(() {
                                        age++;
                                      });
                                    },
                                  heroTag: "age+",
                                  mini: true,
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("WEIGHT",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            Text("$weight KG",style: TextStyle(fontSize: 25),),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FloatingActionButton(
                                    onPressed: (){
                                      setState(() {
                                        if (weight <= 50){
                                          Fluttertoast.showToast(
                                              msg: "Check Doctor",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 25.0
                                          );
                                        }else {
                                          weight--;
                                        }
                                      });

                                },
                                  heroTag: "weight-",
                                  mini: true,
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                FloatingActionButton(
                                    onPressed: (){
                                      setState(() {
                                        weight++;
                                      });
                                    },
                                    heroTag: "weight+",
                                    mini: true,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    ),
                                    ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ),
            Container(
              width: double.infinity,
              decoration:BoxDecoration(
                color: Colors.grey,
              ),
              child: MaterialButton(onPressed: (){

                var result = weight /pow(userHeight/100, 2);

                Navigator.push(context, MaterialPageRoute(builder: (context)=>BMIResults(age,userHeight,weight,result,isMale)));
              },
                child: Text(
                  "Calculate",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                  ),
                ),
              ),
            ),
          ],
        ),


    );
  }
}
