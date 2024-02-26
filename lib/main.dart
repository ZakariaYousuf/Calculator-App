import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  String operand = '';
  double num1 = 0.0;
  double num2 = 0.0;

  final List<String> buttons = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '=',
    '+',
  ];

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        clear();
      } else if (buttonText == "=") {
        calculate();
      } else if (isNumeric(buttonText)) {
        if (operand.isEmpty) {
          if (displayText == '0') {
            displayText = buttonText;
          } else {
            displayText += buttonText;
          }
        } else {
          if (displayText == '0') {
            displayText = buttonText;
          } else {
            displayText += buttonText;
          }
        }
      } else {
        if (operand.isEmpty) {
          num1 = double.parse(displayText);
          operand = buttonText;
          displayText = '0';
        }
      }
    });
  }

  void clear() {
    setState(() {
      displayText = '0';
      operand = '';
      num1 = 0.0;
      num2 = 0.0;
    });
  }

  void calculate() {
    setState(() {
      num2 = double.parse(displayText);
      switch (operand) {
        case "+":
          displayText = (num1 + num2).toString();
          break;
        case "-":
          displayText = (num1 - num2).toString();
          break;
        case "x":
          displayText = (num1 * num2).toString();
          break;
        case "/":
          displayText = (num1 / num2).toString();
          break;
      }
      operand = '';
      num1 = 0.0;
      num2 = 0.0;
    });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          for (int i = 0; i < buttons.length; i += 4)
            buildButtonRow(buttons.sublist(i, i + 4)),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons
            .map((buttonText) => Expanded(
                  child: ElevatedButton(
                    onPressed: () => buttonPressed(buttonText),
                    child: Text(
                      buttonText,
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
