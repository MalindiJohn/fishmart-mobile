import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SaleCard extends StatelessWidget {
  const SaleCard({

    super.key,

    //the incoming data
     required this.productName,
     required this.price,
     required this.quantity,
     required this.totalPrice,
     required this.description,
     required this.onPressed,


  });

     //define the variables of incoming data
     final String productName;
     final String price;
     final String quantity;
     final String totalPrice;
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
                    child: Text("$productName", 
                    style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 15),)),
                  
                  Expanded(
                    child: Text("KES: $price.00", 
                    style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 15),)),

                  Expanded(
                    child: Text("Quantity: $quantity", 
                    style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 15),)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Total Price", 
                    style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 14, color: Colors.grey[600]),)),

                  Expanded(
                  child: Text("KES $totalPrice.00", 
                  style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 14, color: Colors.grey[600]),)),
                ],
              ),

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