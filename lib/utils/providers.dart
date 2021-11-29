import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItemCounter with ChangeNotifier, DiagnosticableTreeMixin {
  int _itemCount = 0;

  int get itemCount => _itemCount;

  void setItemCount(int count) {
    _itemCount = count;
    notifyListeners();
  }

  void plusOne() {
    _itemCount++;
    notifyListeners();
  }

  void minusOne() {
    _itemCount--;
    notifyListeners();
  }

  void setToZero() {
    _itemCount = 0;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty(('itemCount'), itemCount));
  }
}
