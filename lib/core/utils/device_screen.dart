import 'package:flutter/widgets.dart';

class DeviceScreen {
  late final bool mobile;
  late final double screenH;
  late final double screenW;

  static late DeviceScreen deviceScreen;
  factory DeviceScreen() => deviceScreen;
  DeviceScreen._internal();

  static void setAppMeasurements(BuildContext context) {
    deviceScreen = DeviceScreen._internal()
      ..mobile = MediaQuery.of(context).size.width < 600
      ..screenH = MediaQuery.of(context).size.height
      ..screenW = MediaQuery.of(context).size.width;
  }
}

extension DeviceScreenExtension on num {
  double get w => DeviceScreen.deviceScreen.screenW * (this / 100);

  double get h => DeviceScreen.deviceScreen.screenH * (this / 100);

  double get sp => this * (DeviceScreen.deviceScreen.screenH / 800);
}
