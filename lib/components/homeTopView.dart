
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import '../screens/homeScreen.dart';
import '../screens/profileScreen.dart';

class HomeTopViewWidget extends StatelessWidget {
  const HomeTopViewWidget({
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
                  height: MediaQuery.of(context).size.height * .24,
                  width: double.infinity,)),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
                                    padding: const EdgeInsets.all(8),
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
                              onTap: () {

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
                          ),

                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              child: Text("Forex | Crypto | Commodities | Indices | Binary",
                                style: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.w600,
                                    color: bgColor,
                                    fontFamily: "K2D-Regular",
                                ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
    
  }
}