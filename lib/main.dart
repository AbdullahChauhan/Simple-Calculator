import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _number1Ctrl = TextEditingController();
  TextEditingController _number2Ctrl = TextEditingController();

  double _result;
  static List<String> _operations = [
    'Select Operation',
    'Addition',
    'Subtraction',
    'Multiplication',
    'Division'
  ];

  String _currentItemSelected = _operations[0];

  @override
  void initState() {
    _result = 0.0;
    super.initState();
  }

  void _onDropItemSelected(String newItemSelect) {
    setState(() {
      _currentItemSelected = newItemSelect;
    });
  }

  String _generateResult() {
    return _currentItemSelected == 'Select Operation' ? 'Please select operation first' : _result.toString(); 
  }

  double _addition(double number1, double number2) {
    return number1 + number2;
  }

  double _subtraction(double number1, double number2) {
    return number1 - number2;
  }

  double _multiplication(double number1, double number2) {
    return number1 * number2;
  }

  double _division(double number1, double number2) {
    return number1 / number2;
  }

  void _selectOperation() {
    final number1 = double.parse(_number1Ctrl.text);
    final number2 = double.parse(_number2Ctrl.text);
    double result;
    switch (_currentItemSelected) {
      case 'Addition':
        result = _addition(number1, number2);
        setState(() {
          _result = result;
        });
        break;
      case 'Subtraction':
        result = _subtraction(number1, number2);
        setState(() {
          _result = result;
        });
        break;
      case 'Multiplication':
        result = _multiplication(number1, number2);
        setState(() {
          _result = result;
        });
        break;
      case 'Division':
        result = _division(number1, number2);
        setState(() {
          _result = double.parse(result.toStringAsFixed(3));
        });
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(_result);
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            DropdownButton(
              value: _currentItemSelected,
              items: _operations.map((String dropdownStringItem) {
                return DropdownMenuItem(
                  child: Text(dropdownStringItem),
                  value: dropdownStringItem,
                );
              }).toList(),
              onChanged: (value) {
                _onDropItemSelected(value);
              },
            ),
            TextField(
              controller: _number1Ctrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter number'),
            ),
            TextField(
              controller: _number2Ctrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter number'),
            ),
            Container(
              padding: EdgeInsets.only(top: 8.0),
              width: double.infinity,
              child: RaisedButton(
                onPressed: _selectOperation,
                child: Text('Calculate'),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              'Result: ${_generateResult()}',
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
