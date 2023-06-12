// import 'dart:js_util';
import 'dart:ui';
// import 'splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:responsive_calculator/main.dart';
import 'dart:math';
// import 'dart:math';

import 'package:responsive_calculator/splashscreen.dart';

void main() {
  runApp(const MaterialApp(
    // home: CalculatorApp(),
    home: splash(),
    debugShowCheckedModeBanner: false,
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  // //calculation part//
  double input1 = 0;
  double input2 = 0;
  String input = '';
  String output = '';
  var operation = '';

  onbuttonclick(value) {
    if (value == 'x') {
      value = '*';
      //so that x can be read as *//
    }
    if (value == 'DEL') {
      if (input != '') {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == 'C') {
      input = '';
      output = '';
    } else if (value == '=') {
      Parser p = Parser();
      Expression expression = p.parse(input);
      ContextModel contextModel = ContextModel();

      var ans = expression.evaluate(EvaluationType.REAL, ContextModel());
      output = ans.toString();

      if (output.endsWith('.0'))
        output = output.substring(0, output.length - 2);
      input = output;
      output = '';
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Apna Calculator'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(input,
                    style: TextStyle(fontSize: 50, color: Colors.white)),
                SizedBox(
                  height: 40,
                ),
                Text(output,
                    style: TextStyle(fontSize: 30, color: Colors.white)),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )),
          Row(
            children: [
              buttonbyme(text: 'C', bgcolor: Colors.blueAccent),
              buttonbyme(text: '%', bgcolor: Colors.blueAccent),
              buttonbyme(text: 'DEL', bgcolor: Colors.blueAccent),
              buttonbyme(text: '/', bgcolor: Colors.blueAccent),
            ],
          ),
          Row(
            children: [
              buttonbyme(text: '7'),
              buttonbyme(text: '8'),
              buttonbyme(text: '9'),
              buttonbyme(text: 'x', bgcolor: Colors.blueAccent),
            ],
          ),
          Row(
            children: [
              buttonbyme(text: '4'),
              buttonbyme(text: '5'),
              buttonbyme(text: '6'),
              buttonbyme(text: '-', bgcolor: Colors.blueAccent),
            ],
          ),
          Row(
            children: [
              buttonbyme(text: '1'),
              buttonbyme(text: '2'),
              buttonbyme(text: '3'),
              buttonbyme(text: '+', bgcolor: Colors.blueAccent),
            ],
          ),
          Row(
            children: [
              buttonbyme(text: '00'),
              buttonbyme(text: '0'),
              buttonbyme(text: '.'),
              buttonbyme(text: '=', bgcolor: Colors.transparent),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonbyme({text, textcolor = Colors.blue, bgcolor = Colors.blue}) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: bgcolor,
                  padding: EdgeInsets.all(10),
                ),
                onPressed: () => onbuttonclick(text),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ))));
  }
}
