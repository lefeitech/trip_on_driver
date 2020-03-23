import 'package:flutter/material.dart';

class TabProvider with ChangeNotifier {
  int get index => _index;
  int _index = 0;

  void changeTab(int index) {
    if (index >= 0 && index < 4) {
      _index = index;
      notifyListeners();
    }
  }
}
