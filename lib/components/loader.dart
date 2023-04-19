import 'package:flutter/material.dart';


class LoaderWidget extends StatelessWidget {
  const LoaderWidget({ 
    Key? key,
    required this.loaderText,
    required this.color
    }) : super(key: key);

    final String loaderText;
    final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Column(
            children: [
               CircularProgressIndicator(
                color: color,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                loaderText,
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                  fontFamily: 'Poppins-Thin',
                  fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
        ),
      );
  }
}