import 'package:fishmartmobile/components/decoratedButton.dart';
import 'package:fishmartmobile/screens/fishFarmInfoScreen.dart';
import 'package:fishmartmobile/screens/salesInfoScreen.dart';
import 'package:flutter/material.dart';

import '../components/errorComponent.dart';
import '../components/loader.dart';
import '../components/saleCard.dart';
import '../components/topView.dart';
import 'package:fishmartmobile/globals.dart' as globals;

import '../constants/colors.dart';
import '../services/networkOperations.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  static String routeName = "/sales";

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: <Widget>[

              const TopViewWidget(heading: "Sales", flex: 1, childView: true),

              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                    
                                  // const Text("All your Sales records", style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 18),),
                                  Row(
                                    children: <Widget>[
                                      const Expanded(
                                        flex: 2,
                                        child: Text("All your Sales records", 
                                        style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 18),)),

                                      Expanded(
                                        flex: 1,
                                      child: InkWell(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: primaryColor
                                          ),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.add, color: colorWHite,),
                                              Text("Add a sale",  style: TextStyle(fontFamily: "Poppins-Regular", color: colorWHite))
                                            ],
                                          ),
                                        ),
                                        onTap: (){

                                          Navigator.pushNamedAndRemoveUntil(context, SalesInfoScreen.routeName, (route) => false);
                                        },
                                      )
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                    
                                  //A future widget to get a data from a future function
                                  FutureBuilder(
                                    //future function
                                    future: getSales(),
                                    builder: (context, snapshot){

                                      //check if future is waiting for results
                                      if(snapshot.connectionState == ConnectionState.waiting){

                                        return const LoaderWidget(loaderText: "Getting sales ... Please wait a second", color: primaryColor);
                                      }
                                    
                                      // check if snapshot has data
                                      if(snapshot.hasData){
                                    
                                        //convert the data into map
                                        var data = snapshot.data as List;

                                        print(data);
                                    
                                        //check if the locations data is empty
                                        if(data.toString() != '[]'){

                                          //loop through returned locations
                                          return ListView.builder(
                                            itemCount: data.length,
                                            physics: const NeverScrollableScrollPhysics(),
                                            //creates scrollable linear array of widgets
                                            shrinkWrap: true,
                                            itemBuilder: (context, index){
                                    
                                              //return location card widget
                                              return SaleCard(
                                                productName: data[index]['productName'], 
                                                price: data[index]['price'], 
                                                quantity: data[index]['quantity'], 
                                                totalPrice: data[index]['totalPrice'],
                                                description: data[index]['description'],
                                                onPressed: () async{

                                                  print("This sale was clicked");

                                                  globals.saleID = data[index]['id'].toString();

                                                  // Navigator.pushNamedAndRemoveUntil(context, FishFarmInfoScreen.routeName, (route) => false);
                                    
                                                });
                                            });
                                    
                                        } 
                                        //if snapshot has no data
                                        else{
                                    
                                          //return an error widget
                                          return const ErrorComponentWidget(errorText: "Whoops! Seems like there are no sales records at the moment.");
                                    
                                        }
                                      } else if(snapshot.hasError){
                                    
                                        //return an error widget
                                        return const ErrorComponentWidget(errorText: "Whoops! Seems like something went wrong. Probably a network or server error");
                                      }
                                    
                                      //return loader widget while waiting for data to finish
                                      return const LoaderWidget(loaderText: "Getting Sales' data ... Please wait a second", color: primaryColor);
                                    }
                                    ),
                                  ],
                      ),
                    ),
                ),
              ),
            ]
          )
        )
      );
  }
}