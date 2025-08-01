import 'package:fast2mine_challenge/core/utils/colors.dart';
import 'package:fast2mine_challenge/core/utils/device_screen.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  final String title;
  final String? itemText;
  final Widget? containerWidget;

  const HomeContainer({
    super.key,
    this.itemText,
    this.containerWidget,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.5.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: fontColor,
            ),
          ),
          SizedBox(height: 0.75.h),
          if (itemText != null)
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: secondaryContainerColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                itemText!,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          if (containerWidget != null) containerWidget!
        ],
      ),
    );
  }
}
