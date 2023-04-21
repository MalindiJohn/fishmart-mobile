import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({

    super.key,

    //the incoming data
     required this.name,
     required this.amount,
     required this.description,
     required this.onPressed,


  });

     //define the variables of incoming data
     final String name;
     final String amount;
     final String description;
     final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: onPressed, 
      child: Container(
          // height: MediaQuery.of(context).size.height * 0.07,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                spreadRadius: 5,
                blurRadius: 2,
                offset: Offset(0, 3),
                blurStyle: BlurStyle.outer
              )
            ]              ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("$name", 
                    style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 15),)),
                  
                  Expanded(
                    child: Text("KES: $amount.00", 
                    style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 15),)),
                ],
              ),
              const SizedBox(height: 10,),

               const Divider(),

              Row(
                children: <Widget>[
                    Expanded(
                      child: Text(description , 
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: "Poppins-Regular", fontSize: 14, color: Colors.grey[600]),)) 
                ],
              ),
              
            ],
          ),
      ),
    );
  }
}