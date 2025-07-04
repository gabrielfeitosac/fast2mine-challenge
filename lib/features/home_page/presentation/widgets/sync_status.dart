import 'package:fast2mine_challenge/core/utils/colors.dart';
import 'package:flutter/material.dart';

class SyncStatus extends StatelessWidget {
  final int unsynchronizedQuantity;

  const SyncStatus({super.key, required this.unsynchronizedQuantity});

  @override
  Widget build(BuildContext context) {
    return unsynchronizedQuantity == 0
        ? Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: sucessColor,
              ),
              SizedBox(width: 5),
              Text(
                'Dados sincronizados',
                style: TextStyle(
                  color: fontColor,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
        : Row(
            children: [
              Icon(
                Icons.error_outlined,
                color: errorColor,
              ),
              SizedBox(width: 5),
              Text(
                '$unsynchronizedQuantity ciclos pendentes de envio',
                style: TextStyle(
                  color: fontColor,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          );
  }
}
