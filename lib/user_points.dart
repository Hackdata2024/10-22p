import 'package:flutter/material.dart';
class UserPointsProvider extends ChangeNotifier {
  int _userPoints = 0;

  int get userPoints => _userPoints;

  void updateUserPoints(int totalLength) {
    _userPoints += totalLength;
    notifyListeners();
  }
}