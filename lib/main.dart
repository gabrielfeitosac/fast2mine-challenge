import 'package:fast2mine_challenge/core/config/instances.dart';
import 'package:fast2mine_challenge/core/utils/colors.dart';
import 'package:fast2mine_challenge/core/utils/device_screen.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initInstances();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DeviceScreen.setDeviceScreen(context);
    return MaterialApp(
      title: 'SIMULACAO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      ),
      home: const HomePage(),
    );
  }
}
