import 'package:flutter/material.dart';

import '../constants/colors.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white70,
      child: Center(
        heightFactor: 20,
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width * .8,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: primaryColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Loading... please wait", style: TextStyle(
                fontSize: 18, color: colorWHite, fontFamily: "Poppins-Regular"
              ),),
              const SizedBox(height: 30,),
              Container(
                width: 40,
                height: 40,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorWHite,
                ),
              )
          ],),
        )
      ),
    );
  }
}