import 'package:flutter/material.dart';

class FancyLedController extends ChangeNotifier {
  Color color;

  FancyLedController({
    this.color = Colors.blue,
  });

  void updateColor(Color value) {
    color = value;
    notifyListeners();
  }
}