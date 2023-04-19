import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';


class AuthTopViewWidget extends StatelessWidget {
  const AuthTopViewWidget({

    Key? key,
    //required parameters
    required this.heading,
    required this.flex,

    }) : super(key: key);

    //definition of parameters
    final String heading;
    final int flex;

  @override
  Widget build(BuildContext context) {

    return Expanded(flex: flex,
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
                child: SvgPicture.asset('assets/icons/bg-top-sm.svg',
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * .2,
                  width: double.infinity,)),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/header_logo.svg'),
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
                                    fontFamily: "K2D-Regular"
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