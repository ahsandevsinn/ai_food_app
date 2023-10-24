import 'package:flutter/foundation.dart';

class HomeScreenProvider extends ChangeNotifier{
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  bool setisFavorite(value1,value2) {
    _isFavorite = value1.contains(value2);
    notifyListeners();
    return _isFavorite;
  }
}