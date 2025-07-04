import 'package:fast2mine_challenge/core/utils/device_screen.dart';
import 'package:flutter/widgets.dart';

class VerticalSpacing extends StatelessWidget {
  final double spacing;

  const VerticalSpacing(this.spacing, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: spacing.h,
    );
  }
}
