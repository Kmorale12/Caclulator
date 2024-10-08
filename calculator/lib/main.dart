import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget { // Change to StatefulWidget
  const CalculatorHomePage({super.key});

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> { 
  String _display = '';
  String _operand1 = ''; //create different variables to store the first operand, second operand, and operator
  String _operand2 = '';
  String _operator = '';

  void _buttonPressed(String value) { // Add a function to handle button presses
    setState(() {
      if (value == '+' || value == '-' || value == '*' || value == '/') { // Check if the value is an operator
        _operator = value;
        _operand1 = _display;
        _display = '';
      } else if (value == '=') {
        _operand2 = _display;
        _calculateResult();
      } else if (value == '.') {
        if (!_display.contains('.')) {
          _display += value;
        }
      } else {
        _display += value;
      }
    });
  }

  void _calculateResult() {
    double num1 = double.parse(_operand1); //parse the operands to double
    double num2 = double.parse(_operand2);
    double result;

    switch (_operator) { //perform the calculation based on the operator
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      default:
        result = 0.0;
    }

    setState(() {
      _display = result.toString();
      _operand1 = '';
      _operand2 = '';
      _operator = '';
    });
  }

  void _clear() {
    setState(() {
      _display = '';
      _operand1 = '';
      _operand2 = '';
      _operator = '';
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: InkWell(
        onTap: () => _buttonPressed(value),
        child: Container(
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white, // Button background color
            border: Border.all(color: Colors.black), // Button border color
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Expanded( // Add the clear button
      child: InkWell(
        onTap: _clear,
        child: Container(
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red, // Clear button background color
            border: Border.all(color: Colors.black), // Button border color
          ),
          child: const Text(
            'C',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      backgroundColor: Colors.grey[300], // Set background color to gray
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('0'),
                  _buildButton('.'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildClearButton(), // Add the clear button
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}