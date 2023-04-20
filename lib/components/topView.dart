import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../screens/homeScreen.dart';
import '../screens/profileScreen.dart';
import 'package:fishmartmobile/globals.dart' as globals;

class TopViewWidget extends StatelessWidget {
  const TopViewWidget({
    Key? key,
    //required parameters
    required this.heading,
    required this.flex,
    required this.childView,
    
    }) : super(key: key);


  //definition of parameters
    final String heading;
    final int flex;
    final bool childView;

  @override
  Widget build(BuildContext context) {

    return Expanded(flex: flex,
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
                child: SvgPicture.asset('assets/icons/bg-top-sm.svg',
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * .22,
                  width: double.infinity,)),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: childView == true ? Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset('assets/icons/back_icon.svg', height: 25,),
                                    )) : Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: SvgPicture.asset('assets/icons/menu_icon.svg'),
                                  ),
                                ),
                                onTap: () {
                                 if (childView == true) {

                                      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);

                                 } else {

                                    Scaffold.of(context).openDrawer();

                                 }
                              },),
                              SvgPicture.asset('assets/icons/header_logo.svg'),
                              childView == true ? Container() : GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset('assets/icons/user_icon.svg'),
                                  ),
                              onTap: () async{
                                //   //get token of logged in user
                                  var prefs = await SharedPreferences.getInstance();
                                  var email = prefs.getString('email');

                                  globals.loggedInUserEmail = email!;

                                   // ignore: use_build_context_synchronously
                                   Navigator.pushNamedAndRemoveUntil(context, ProfileScreen.routeName, (route) => true);
                              },),
                            ],
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                              child: Text(heading,
                                style: const TextStyle(
                                    fontSize: 25,
                                    // fontWeight: FontWeight.w600,
                                    color: bgColor,
                                    fontFamily: "K2D-Regular",
                                ),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container()
                ],
              ),
            ),
          ],
        )
    );
    
  }
}