import 'package:fast2mine_challenge/core/config/instances.dart';
import 'package:fast2mine_challenge/core/utils/colors.dart';
import 'package:fast2mine_challenge/core/utils/device_screen.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    bool firstFrameAllowed = false;
    DeviceScreen.setDeviceScreen(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            if (MediaQuery.of(context).size == Size.zero) {
              return const SizedBox();
            }
            if (!firstFrameAllowed) {
              RendererBinding.instance.allowFirstFrame();
              firstFrameAllowed = true;
            }
            DeviceScreen.setDeviceScreen(context);
            if (constraints.maxWidth == 0 || constraints.maxHeight == 0) {
              return const SizedBox();
            }
            return MaterialApp(
              title: 'SIMULACAO',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              ),
              home: const HomePage(),
            );
          },
        );
      },
    );
  }
}
