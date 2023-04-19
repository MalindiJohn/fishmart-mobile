import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ErrorComponentWidget extends StatelessWidget {
  const ErrorComponentWidget({ 
    Key? key,
    required this.errorText,
    }) : super(key: key);

    final String errorText;

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
                SvgPicture.asset("assets/images/no_stock_count_process.svg", 
                height: MediaQuery.of(context).size.height * 0.09,),

                const SizedBox(height: 20,),
                Text(errorText, 
                          style: TextStyle(fontFamily: "Poppins-Regular", fontSize: 14, color: Colors.red[300]),
                          textAlign: TextAlign.center,
                          )
              ],
            ),
          );
  }
}