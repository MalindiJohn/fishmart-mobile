import 'package:flutter/material.dart';

class DecoratedButton extends StatelessWidget {
  const DecoratedButton({
    Key? key, 
    required this.text, 
    required this.onPressed, 
    required this.primaryColor, 
    required this.textColor,
    required this.icon,
    }) : super(key: key);
  final String text;
  final Function() onPressed;
  final Color primaryColor;
  final Color textColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: primaryColor, 
        onPrimary: textColor
        ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 50,),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, ),
            ),
          ],
        ),
      ),
    );
  }
}
