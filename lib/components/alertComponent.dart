import 'package:fishmartmobile/components/errorComponent.dart';
import 'package:fishmartmobile/components/successComponent.dart';
import 'package:fishmartmobile/screens/salesScreen.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../screens/expensesScreen.dart';
import '../screens/homeScreen.dart';

showAlertDialog(
  BuildContext context,
  String message,
  String errorText,
  String type,
  bool isSuccess
  ) {

  // set up the button
  Widget okButton = ElevatedButton(
    child: isSuccess?  Text('Continue to $type', style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 13), )
     : const Text("Take Me Back",
    style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 13),),
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
    ),
    onPressed: () {
      isSuccess ?
      // then navigate to the home screen, with user info and materials.
        type == "sales" ? Navigator.pushNamedAndRemoveUntil(context,
          SalesScreen.routeName, (route) => false) : 

          Navigator.pushNamedAndRemoveUntil(context,
          ExpensesScreen.routeName, (route) => false)

           :
      
       Navigator.pop(context);
      
     },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    // title: const Text("Response Message"),
    content: SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children:  [
            isSuccess? SuccessComponentWidget(successText: errorText):
            ErrorComponentWidget(errorText: errorText),
            isSuccess? Container(): Container(
              alignment: Alignment.topLeft,
              child: const Text('Reason', style: TextStyle(fontFamily: 'Poppins-Medium'),)),
            const Divider(),
            isSuccess? Container() : Container(
              alignment: Alignment.topLeft,
              child: Text(message, 
              style: const TextStyle(fontFamily: 'Poppins-Regular', fontSize: 13),)),
            
          ],
        ),
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}