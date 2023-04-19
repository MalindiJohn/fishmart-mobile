import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';

class DecoratedInputBox extends StatelessWidget {
  const DecoratedInputBox(
      {
        Key? key, 
        required this.hintText,
         required this.inputType, 
         required this.secureText, 
         required this.controller,
         required this.icon,
         required this.label,
         required this.horizontalPadding,
         required this.verticalPadding,
          })
      : super(key: key);

  final String hintText;
  final bool secureText;
  final TextInputType inputType;
  final TextEditingController controller;
  final Icon icon;
  final String label;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontFamily: "Poppins-Regular", fontSize: 17,),),
        const SizedBox(height: 5,),
        Container(
          decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: strokeColor, width: 1),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 18),
              obscureText: secureText,
              keyboardType: inputType,
              decoration:
                  InputDecoration(
                    border: InputBorder.none, 
                    hintText: hintText,
                    prefixIcon: icon,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}