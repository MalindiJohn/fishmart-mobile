import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../components/errorComponent.dart';
import '../components/loader.dart';
import '../components/topView.dart';
import '../constants/colors.dart';
import '../services/networkOperations.dart';
import 'package:fishmartmobile/globals.dart' as globals;


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: <Widget>[

              const TopViewWidget(heading: "My Profile", flex: 1, childView: true),

              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: FutureBuilder(
                    future: getLoggedInMember(),
                    builder: (context, snapshot){

                      if(snapshot.hasData){

                        //convert response data to Maps of data
                        var data = snapshot.data as Map;

                        return Container(
                          child: Column(
                            children: <Widget>[

                              Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(
                                // color: primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: primaryColor)
                              ),
                              child: Icon(Feather.user, size: MediaQuery.of(context).size.width * .15, color: primaryColor,),
                              ),

                              const SizedBox(height: 10,),

                              Text(data['firstName']+" "+data['lastName'], style: TextStyle(fontFamily: "K2D-Medium", fontSize: 25),),

                              const SizedBox(height: 10,),

                              const Divider(color: primaryColor,),

                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Icon(AntDesign.phone, color: primaryColor,),
                                    const SizedBox(width: 40,),
                                    Text(data['telephone'], style: TextStyle(fontFamily: "K2D-Medium", fontSize: 15),)
                                  ],
                                ),
                              ),

                              const Divider(),
                              
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(AntDesign.mail, color: primaryColor,),
                                    SizedBox(width: 40,),
                                    Text(globals.loggedInUserEmail, style: TextStyle(fontFamily: "K2D-Medium", fontSize: 15),)
                                  ],
                                ),
                              ),

                              const Divider(),
                              
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Icon(MaterialIcons.location_on, color: primaryColor,),
                                    const SizedBox(width: 40,),
                                    Text(data['location'], style: TextStyle(fontFamily: "K2D-Medium", fontSize: 15),)
                                  ],
                                ),
                              ),

                              const Divider(),

                            ],
                          ),
                        );
                      } else if(snapshot.hasError){

                        return const ErrorComponentWidget(errorText: "Whoops! Could not load the profile data. Probably a server error. Try again later");
                      }

                      return const LoaderWidget(loaderText: "A second, loading profile data . . .", color: primaryColor);
                    }
                  )
                )
                )
          ],
        )
        ),
    );
    
  }
}