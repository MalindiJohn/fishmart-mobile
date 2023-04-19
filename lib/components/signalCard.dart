import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/colors.dart';


class SignalCard extends StatelessWidget {
  const SignalCard({
    Key? key,
    required this.currency,
    required this.sellStopOrder,
    required this.date,
    required this.takeProfit1,
    required this.takeProfit2,
    required this.takeProfit3,
    required this.stopLoss,
    required this.status,
    required this.recommend,
    required this.result
    }) : super(key: key);

  final String currency;
  final String sellStopOrder;
  final String date;
  final String takeProfit1;
  final String takeProfit2;
  final String takeProfit3;
  final String stopLoss;
  final String status;
  final String recommend;
  final String result;


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          // height: MediaQuery.of(context).size.height * .2,
          decoration:  const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colorWHite,
                blurRadius: 1.0,
                spreadRadius: 5.0,
                offset: Offset(0, 0),

              ),
            ]
          ),
          child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          
              Text(currency, style: const TextStyle(fontFamily: "K2D-Bold", fontSize: 15, color: primaryColor),),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Row(
                  children: [
                     Expanded(child: Text(recommend == "SELL"? "SELL STOP ORDER" : "BUY STOP ORDER", style: TextStyle(fontFamily: "K2D-Medium", color: recommend == "SELL"? errorCOlor : successColor),)),
                    Expanded(child: Text(sellStopOrder, style: const TextStyle(fontFamily: "K2D-Regular"),)),
                    Expanded(child: Text(date, style: const TextStyle(fontFamily: "K2D-Regular"),))
                  ],
                ),
              ),
              const Divider(),

              Container(
                child: Column(
                  children: [
                  Row(
                    children: const [
                      Expanded(child: Text('TAKE PROFIT 1', style: TextStyle(fontFamily: "K2D-Medium"),)),
                      Expanded(child: Text('TAKE PROFIT 2', style: TextStyle(fontFamily: "K2D-Medium"),)),
                      Expanded(child: Text('TAKE PROFIT 3', style: TextStyle(fontFamily: "K2D-Medium"),))
                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Expanded(child: Text(takeProfit1, style: TextStyle(fontFamily: "K2D-Regular"),)),
                      Expanded(child: Text(takeProfit2, style: TextStyle(fontFamily: "K2D-Regular"),)),
                      Expanded(child: Text(takeProfit3, style: TextStyle(fontFamily: "K2D-Regular"),))
                    ],
                  ),

                ],),
              ),

              const Divider(),
          
              Row(
                children: [
                  Expanded(child: Row(
                    children: [
                      
                      Text('STOP LOSS : ', style: TextStyle(fontFamily: "K2D-Medium", color: recommend == "SELL"? errorCOlor : successColor)),
                      Text(stopLoss, style: TextStyle(fontFamily: "K2D-Regular"))

                    ],
                  ),),
                   Expanded(child: Row(
                    children: [
                      
                      const Text('Status : ', style: TextStyle(fontFamily: "K2D-Medium")),
                      // Text(status, style: TextStyle(fontFamily: "K2D-Regular", color: primaryColor))
                      RichText(
                        text: TextSpan(
                          text: status,
                          style: const TextStyle(fontFamily: "K2D-Regular", color: primaryColor),
                          children: <TextSpan>[
                              TextSpan(text: result.isEmpty? "": " ($result)", style: TextStyle(fontFamily: "K2D-Regular", color: result == "SL HIT"? errorCOlor : successColor))
                          ]
                        )
                      ),

                    ],
                  ),),
                ],
              ),

              const Divider(),

              Row(
                children: [
                  Expanded(child: Row(
                    children: [
                      
                      const Text('G. Market Sentiment : ', style: TextStyle(fontFamily: "K2D-Medium")),
                      Text(recommend, style: TextStyle(fontFamily: "K2D-Regular", color: recommend == "SELL"? errorCOlor : successColor))

                    ],
                  ),),

                  Expanded(child: Row(
                    children: [
                      
                      const Text('Technical Indicators : ', style: TextStyle(fontFamily: "K2D-Medium")),
                      Text(recommend, style: TextStyle(fontFamily: "K2D-Regular", color: recommend == "SELL"? errorCOlor : successColor))

                    ],
                  ),),
                ],
              ),

              const SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(child: Row(
                    children: [
                      
                      const Text('Fundamental Indicators : ', style: TextStyle(fontFamily: "K2D-Medium")),
                      Text(recommend, style: TextStyle(fontFamily: "K2D-Regular", color: recommend == "SELL"? errorCOlor : successColor))

                    ],
                  ),),
                  Expanded(child: Row(
                    children: [
                      
                      const Text('Summary : ', style: TextStyle(fontFamily: "K2D-Medium")),
                      Text(recommend, style: TextStyle(fontFamily: "K2D-Regular", color: recommend == "SELL"? errorCOlor : successColor))

                    ],
                  ),),
                ],
              ),
            ],
          ),
        ),

        const Divider(thickness: 3),
      ],
    );
    
  }
}