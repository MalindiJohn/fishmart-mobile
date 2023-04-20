import 'package:flutter/material.dart';
import '../constants/colors.dart';

class FishInfoCard extends StatelessWidget {
  const FishInfoCard({

    super.key,

    //the incoming data
     required this.title,
     required this.subTitle,
     required this.description,
     required this.onPressed,
    });

     //define the variables of incoming data
     final String title;
     final String subTitle;
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
                    child: Text(title, 
                    style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 15),)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(subTitle, 
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