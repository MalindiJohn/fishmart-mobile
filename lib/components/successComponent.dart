import 'package:fishmartmobile/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SuccessComponentWidget extends StatelessWidget {
  const SuccessComponentWidget({
     Key? key,
     required this.successText
     }) : super(key: key);

    final String successText;

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/success_icon.svg", 
                height: MediaQuery.of(context).size.height * 0.15,),

                const SizedBox(height: 20,),
                Text(successText, 
                          style: const TextStyle(fontFamily: "Poppins-Regular", fontSize: 14,),
                          textAlign: TextAlign.center,
                          )
              ],
            ),
          );
  }
}