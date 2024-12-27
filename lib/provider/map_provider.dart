import 'package:flutter/material.dart';

class MapProvider with ChangeNotifier {
  Offset? qrCodePosition;

  void setQRCodePosition(Offset position) {
    qrCodePosition = position;
    notifyListeners();
  }
}
