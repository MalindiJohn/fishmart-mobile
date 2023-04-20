import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/errorComponent.dart';
import '../components/loader.dart';
import '../constants/colors.dart';
import '../services/networkOperations.dart';
import 'homeScreen.dart';
import 'package:fishmartmobile/globals.dart' as globals;

class FishFarmInfoScreen extends StatefulWidget {
  const FishFarmInfoScreen({super.key});

  static String routeName = "/fish-farm-info";

  @override
  State<FishFarmInfoScreen> createState() => _FishFarmInfoScreenState();
}

class _FishFarmInfoScreenState extends State<FishFarmInfoScreen> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
 
       statusBarColor: primaryColor,
       
    ));
    
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Container (
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
          child: InkWell(
            child: SvgPicture.asset('assets/icons/back_icon.svg', height: 10,),
            onTap: (){

              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => true);
            },
            )
        ),

        title: Container(
          child: Text(globals.fishInfoTitle, style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 18),),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[

            //load header
            // TopViewWidget(
            //   heading: "Materials", 
            //   subHeading: location, 
            //   description: "Counting of Materials", 
            //   otherDescription: "status : "+locationStockTakingStatus+". You are "+((teamLead == "1"? "a Team Lead" : "not a Team Lead")), 
            //   flex: 1, 
            //   childView: true),

            //new header here


            //here is body of location screen
            SizedBox(height: 20,),
            Expanded(
              flex : 2,
              child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                                
                        //materials header
                        Text(globals.fishInfoSubTitle, style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 17),),
                        const Divider(color: lightGreyColor,),
                                
                        FutureBuilder(
                          future: getSingleFishInfo(globals.fishInfoId),
                          builder: (context, snapshot){
                                      
                            // //check if future is waiting for results
                            if(snapshot.connectionState == ConnectionState.waiting){
                                      
                              return const LoaderWidget(loaderText: "Getting single fish info data ... Please wait a second", color: primaryColor);
                            }
                                
                            //check if snapshot has data
                            if(snapshot.hasData){
                                
                              //map the data
                              var data = snapshot.data as Map; 

                              print(data);
                                
                                //check if materials returned empty array
                                if(data.toString() != '[]'){
                                
                                    //iterate through the materials' data returned from the future
                                  return Container(
                                    child: Text(data['description'],
                                    style: TextStyle(fontFamily: "Poppins-Regular", fontSize: 14, color: Colors.grey[600])),
                                  );
                                  
                                  // FishInfoComponent();
                                
                                } else{
                                
                                  //if it returns an empty array which is like impossible
                                  //because this condition is inside another 'not null' condition
                                  //but it might happen one day
                                  var errorMessage = "Whoops! This is not supposed to happen. Possibly null safety is compromised";
                                
                                  //if it happens  
                                  //show error widget
                                  return ErrorComponentWidget(errorText: errorMessage);
                                }
                                
                            } 
                            
                            //If snapshot has error
                            else if(snapshot.hasError){
                                
                                //return error widget
                                return const ErrorComponentWidget(errorText: "Whoops! Seems like something went wrong. Probably a network or server error");
                            }
                                
                            return const LoaderWidget(loaderText: "Getting single fish farming info' data  .  .  . Please wait a second", color: primaryColor);
                          }
                          ),
                                
                      ],
                    ),
                  ),
                ),
              )
          ],
        )
        ),
      
    );
  }
}