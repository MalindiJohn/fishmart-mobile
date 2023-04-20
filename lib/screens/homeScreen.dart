import 'package:fishmartmobile/screens/fishFarmInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../components/errorComponent.dart';
import '../components/fishInfoCard.dart';
import '../components/homeTopView.dart';
import '../components/loader.dart';
import '../components/sideDrawer.dart';
import '../constants/colors.dart';
import '../services/networkOperations.dart';
import 'package:fishmartmobile/globals.dart' as globals;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
 
       statusBarColor: primaryColor,
       
    ));

    return Scaffold(
      backgroundColor: colorWHite,
      drawer: const SideDrawerWidget(),
      body: Column(
      children: <Widget>[

        const HomeTopViewWidget(heading: "Fish Farming Info", flex: 1, childView: false),

        Expanded(
              flex: 2,
              child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                  
                                const Text("Fish Farming Info List", style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 18),),
                                const Divider(),
                                const SizedBox(height: 10,),
                  
                                //A future widget to get a data from a future function
                                FutureBuilder(
                                  //future function
                                  future: getFishFarmingInfo(),
                                  builder: (context, snapshot){

                                    //check if future is waiting for results
                                    if(snapshot.connectionState == ConnectionState.waiting){

                                      return const LoaderWidget(loaderText: "Getting fish farming info ... Please wait a second", color: primaryColor);
                                    }
                                  
                                    // check if snapshot has data
                                    if(snapshot.hasData){
                                  
                                      //convert the data into map
                                      var data = snapshot.data as List;
                                  
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
                                            return FishInfoCard(
                                              title: data[index]['title'], 
                                              subTitle: data[index]['subTitle'],
                                              description: data[index]['description'],
                                              onPressed: () async{

                                                globals.fishInfoId = data[index]['id'].toString();

                                                globals.fishInfoTitle = data[index]['title'];

                                                globals.fishInfoSubTitle = data[index]['subTitle'];

                                                Navigator.pushNamedAndRemoveUntil(context, FishFarmInfoScreen.routeName, (route) => false);
                                  
                                              });
                                          });
                                  
                                      } 
                                      //if snapshot has no data
                                      else{
                                  
                                        //return an error widget
                                        return const ErrorComponentWidget(errorText: "Whoops! Seems like the user has no assigned locations");
                                  
                                      }
                                    } else if(snapshot.hasError){
                                  
                                      //return an error widget
                                      return const ErrorComponentWidget(errorText: "Whoops! Seems like something went wrong. Probably a network or server error");
                                    }
                                  
                                    //return loader widget while waiting for data to finish
                                    return const LoaderWidget(loaderText: "Getting Locations' data ... Please wait a second", color: primaryColor);
                                  }
                                  ),
                                ],
                    ),
                  ),
                ),
            ),

      ],
      ),
    );
    
  }
}