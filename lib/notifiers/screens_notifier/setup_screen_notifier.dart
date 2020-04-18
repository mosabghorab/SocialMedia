
import 'package:flutter/foundation.dart';

class SetupScreenNotifier with ChangeNotifier{
  int _pageIndex;

  SetupScreenNotifier(
  ) {
    _pageIndex = 0;
  }

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
}
