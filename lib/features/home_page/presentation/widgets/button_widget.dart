import 'package:fast2mine_challenge/core/utils/device_screen.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final void Function()? onPressed;

  const ButtonWidget({
    super.key,
    required this.text,
    this.icon,
    required this.backgroundColor,
    this.onPressed,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? TextButton.icon(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: textColor,
              size: 4.h,
            ),
            label: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: Size(double.infinity, 50),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        : TextButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: Size(double.infinity, 50),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          );
  }
}
