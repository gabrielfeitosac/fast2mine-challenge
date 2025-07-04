import 'package:fast2mine_challenge/core/utils/colors.dart';
import 'package:flutter/material.dart';

class StatusContainer extends StatelessWidget {
  final String status;

  const StatusContainer({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: containerStatusColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_shipping,
            color: fontStatusColor,
            size: 35,
          ),
          SizedBox(width: 10),
          Text(
            status,
            style: TextStyle(
              color: fontStatusColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
