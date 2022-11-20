import 'package:flutter/material.dart';
import 'package:tip_calculator/utils/hex_color.dart';

class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({super.key});

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  double _inputBill = 100;
  double _totalResult = 101;
  double _totalTip = 1.0;
  int _splitBy = 1;
  int _tipPercentage = 1;

  void _calc() {
    //final canParse = double.tryParse(value);
    //if (canParse == null || canParse <= 0.0) {
    //return;
    //}

    //_inputBill = canParse;

    double tempAllTip;
    double tempAllTotal;
    if (_tipPercentage <= 0) {
      tempAllTip = 0.0;
      tempAllTotal = _inputBill;
    }
    tempAllTip = (_inputBill * _tipPercentage / 100);
    tempAllTotal = _inputBill + tempAllTip;
    if (_splitBy < 1) {
      _splitBy = 1;
    }
    setState(() {
      _totalTip = tempAllTip / _splitBy;
      _totalResult = tempAllTotal / _splitBy;
    });
  }

  late final _purple = HexColor("6908D6");
  final TextStyle _geyTextStyle = TextStyle(
    color: Colors.grey.shade600,
  );
  final TextStyle _boldPurble = TextStyle(
    color: HexColor("6908D6"),
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  @override
  Widget build(BuildContext context) {
    print("Main Widget rebuilted");
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: _purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                child: Column(children: [
                  Text(
                    "Total per person",
                    style: TextStyle(
                      color: _purple,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$${_totalResult.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: _purple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: "100",
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount: ",
                      //labelText: "100",
                    ),
                    onChanged: (value) {
                      print(value);
                      var parsedVal = double.tryParse(value);
                      if (parsedVal == null || parsedVal <= 0.0) {
                        parsedVal = 1.0; // minimum to start calculating
                      }
                      _inputBill = parsedVal;
                      _calc();
                    },
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: _geyTextStyle,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          _splitBy += 1;
                          _calc();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          margin: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: _purple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "+",
                            style: _boldPurble,
                          ),
                        ),
                      ),
                      Text(
                        "$_splitBy",
                        style: _boldPurble,
                      ),
                      InkWell(
                        onTap: () {
                          if (_splitBy > 1) {
                            _splitBy -= 1;
                            _calc();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          margin: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: _purple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "-",
                            style: _boldPurble,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tip",
                        style: _geyTextStyle,
                      ),
                      Spacer(),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            "\$${_totalTip.toStringAsFixed(2)}",
                            style: _boldPurble,
                          )),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "$_tipPercentage%",
                      style: _boldPurble,
                    ),
                  ),
                  Slider(
                      inactiveColor: Colors.grey,
                      activeColor: _purple,
                      divisions: 20,
                      value: _tipPercentage.toDouble(),
                      min: 0,
                      max: 100,
                      onChanged: ((value) {
                        _tipPercentage = value.round();
                        _calc();
                      }))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
