import 'package:fast2mine_challenge/core/utils/colors.dart';
import 'package:fast2mine_challenge/core/utils/device_screen.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/button_widget.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

Future<void> openPopup(
  BuildContext context, {
  required String text,
  required String buttonConfirmText,
  void Function()? onPressedConfirm,
  String? buttonCancelText,
  void Function()? onPressedCancel,
}) {
  return showModalBottomSheet(
    context: context,
    builder: ((context) {
      return IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalSpacing(4),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),
              VerticalSpacing(4),
              ButtonWidget(
                text: buttonConfirmText,
                backgroundColor: buttonColor,
                textColor: primaryColor,
                onPressed: onPressedConfirm ?? () => Navigator.pop(context),
              ),
              VerticalSpacing(1),
              if (buttonCancelText != null)
                ButtonWidget(
                  text: buttonCancelText,
                  backgroundColor: containerColor,
                  textColor: fontColor,
                  onPressed: onPressedCancel ?? () => Navigator.pop(context),
                ),
              VerticalSpacing(10),
            ],
          ),
        ),
      );
    }),
  );
}
