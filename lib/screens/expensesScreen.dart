import 'package:fishmartmobile/screens/ExpensesInfoScreen.dart';
import 'package:flutter/material.dart';

import '../components/errorComponent.dart';
import '../components/expenseCard.dart';
import '../components/loader.dart';
import '../components/topView.dart';
import '../constants/colors.dart';
import 'package:fishmartmobile/globals.dart' as globals;

import '../services/networkOperations.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  static String routeName = "/expenses";

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: <Widget>[

              const TopViewWidget(heading: "Expenses", flex: 1, childView: true),

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
                                        child: Text("All your Expenses records", 
                                        style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 16),)),

                                      Expanded(
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
                                              Text("Add Expense",  style: TextStyle(fontFamily: "Poppins-Regular", color: colorWHite))
                                            ],
                                          ),
                                        ),
                                        onTap: (){

                                          print("this is clicked");

                                          Navigator.pushNamedAndRemoveUntil(context, ExpensesInfoScreen.routeName, (route) => false);
                                        },
                                      )
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                    
                                  //A future widget to get a data from a future function
                                  FutureBuilder(
                                    //future function
                                    future: getExpenses(),
                                    builder: (context, snapshot){

                                      //check if future is waiting for results
                                      if(snapshot.connectionState == ConnectionState.waiting){

                                        return const LoaderWidget(loaderText: "Getting expenses ... Please wait a second", color: primaryColor);
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
                                              return ExpenseCard(
                                                name: data[index]['name'], 
                                                amount: data[index]['amount'], 
                                                description: data[index]['description'], 
                                                onPressed: () async{

                                                  print("This expense was clicked");

                                                  globals.saleID = data[index]['id'].toString();

                                                  // Navigator.pushNamedAndRemoveUntil(context, FishFarmInfoScreen.routeName, (route) => false);
                                    
                                                });
                                            });
                                    
                                        } 
                                        //if snapshot has no data
                                        else{
                                    
                                          //return an error widget
                                          return const ErrorComponentWidget(errorText: "Whoops! Seems like there are no expenses records at the moment.");
                                    
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