import 'package:fishmartmobile/constants/colors.dart';
import 'package:flutter/material.dart';


class BulletComponentWidget extends StatelessWidget {
  const BulletComponentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
        height: 15.0,
        width: 15.0,
        decoration: const BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
      );
    
  }
}