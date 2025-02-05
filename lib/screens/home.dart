import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
// import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String equation = "";
  String expression = "";
  String result = "";
  String operator = "";
  Color yellow = Colors.yellow;
  Color red = Colors.red;
  Color green = Colors.orange;

  buttonCal(String ButtonText) {
    setState(() {
      if (ButtonText == 'C') {
        equation = '';
        result = '';
      } else if (ButtonText == 'AC') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '0') {
          equation = '0';
        }
      } else if (ButtonText == '=') {
        expression= equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
        
      }
    });
  }

  Widget myButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        height: buttonHeight * 90,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: MaterialButton(
          onPressed: () {},
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 35),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text(
          'Calculator App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            equation,
            style: const TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(
            result,
            style: const TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Table(
                children: [
                  TableRow(children: [
                    myButton("+/-", 1, yellow),
                    myButton("%", 1, yellow),
                    myButton("⌫", 1, yellow),
                    myButton("C", 1, yellow),
                  ]),
                  TableRow(children: [
                    myButton("7", 1, green),
                    myButton("8", 1, green),
                    myButton("9", 1, green),
                    myButton("÷", 1, yellow),
                  ]),
                  TableRow(children: [
                    myButton("4", 1, green),
                    myButton("5", 1, green),
                    myButton("6", 1, green),
                    myButton("x", 1, yellow),
                  ]),
                  TableRow(children: [
                    myButton("1", 1, green),
                    myButton("2", 1, green),
                    myButton("3", 1, green),
                    myButton("-", 1, yellow),
                  ]),
                  TableRow(
                    children: [
                      myButton("0", 1, green),
                      myButton(".", 1, green),
                      myButton("+", 1, green),
                      myButton("=", 1, red),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}

class SuperscriptText extends StatelessWidget {
  final String baseText;
  final String superscriptText;

  const SuperscriptText(
      {super.key, required this.baseText, required this.superscriptText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: baseText,
        style: const TextStyle(fontSize: 35, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: superscriptText,
            style: const TextStyle(
              fontSize: 20, // Adjust the font size for the superscript
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
