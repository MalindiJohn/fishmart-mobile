import 'package:fishmartmobile/screens/expensesScreen.dart';
import 'package:fishmartmobile/screens/fishFarmInfoScreen.dart';
import 'package:fishmartmobile/screens/salesScreen.dart';

import '../constants/colors.dart';
import '../screens/loginScreen.dart';
import '../screens/profileScreen.dart';
import '/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loadingComponent.dart';

class SideDrawerWidget extends StatelessWidget {
  const SideDrawerWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 1),
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
          backgroundColor: colorWHite,
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView(  
                    // Important: Remove any padding from the ListView.  
                    children: <Widget>[  

                      //closes the side drawer
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 20, 5),
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const Icon(AntDesign.closecircleo, color: primaryColor,),
                          onTap: (){
                            Navigator.pop(context);
                          },
                          ),
                      ),

                      //bitvex logo
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        // height: MediaQuery.of(context).size.height * 0.1,
                        // width: MediaQuery.of(context).size.width * 0.1,
                        // decoration: const BoxDecoration(
                        //   // color: primaryColor,
                        //   shape: BoxShape.rectangle,
                        // ),
                        child: SvgPicture.asset("assets/icons/fishmart-logo.svg", height: 70,)
                        ),

                      //Logo tag line
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: const Text("Fish Farming Info",style: TextStyle(fontFamily: "K2D-Regular", fontSize: 16, color: primaryColor),)
                        ),
                      Container(
                          alignment: Alignment.center,
                          child: const Text("For farmers",style: TextStyle(fontFamily: "K2D-Regular", fontSize: 16, color: primaryColor),)
                          ),
                      const SizedBox(height: 10,),    
                      const Divider(),  

                      //Home page
                      ListTile(  
                        leading: const Icon(Icons.home, color: primaryColor,), 
                        title: const Text("Home", style: TextStyle(fontFamily: "K2D-Medium", fontSize: 15),),  
                        onTap: () {  

                            //pop out back to home screen
                            Navigator.pop(context); 
                        },  
                      ), 

                      //my profile page 
                      ListTile(  
                        leading: const Icon(Icons.person, color: primaryColor,), 
                        title: const Text("My Profile", style: TextStyle(fontFamily: "K2D-Medium", fontSize: 15),),  
                        onTap: () {  
                          Navigator.pushNamedAndRemoveUntil(context, ProfileScreen.routeName, (route) => false);  
                        },  
                      ),  

                      //expenses page 
                      ListTile(  
                        leading: const Icon(Icons.menu, color: primaryColor,), 
                        title: const Text("Expenses", style: TextStyle(fontFamily: "K2D-Medium", fontSize: 15),),  
                        onTap: () {  
                          Navigator.pushNamedAndRemoveUntil(context, ExpensesScreen.routeName, (route) => false);  
                        },  
                      ), 

                      //sales page 
                      ListTile(  
                        leading: const Icon(Icons.list_alt_outlined, color: primaryColor,), 
                        title: const Text("Sales", style: TextStyle(fontFamily: "K2D-Medium", fontSize: 15),),  
                        onTap: () {  
                          Navigator.pushNamedAndRemoveUntil(context, SalesScreen.routeName, (route) => false);  
                        },  
                      ), 

                      //fish farming info page 
                      ListTile(  
                        leading: const Icon(Icons.info_outline, color: primaryColor,), 
                        title: const Text("Fish Farm Info", style: TextStyle(fontFamily: "K2D-Medium", fontSize: 15),),  
                        onTap: () {  
                          Navigator.pushNamedAndRemoveUntil(context, FishFarmInfoScreen.routeName, (route) => false);  
                        },  
                      ),
                    ],  
                  ),
                ),

                const Divider(),

                //logout page
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: ListTile(  
                        leading: const Icon(Icons.logout, color: primaryColor,), 
                        title: const Text("Log Out", style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 14),),  
                        onTap: () async{

                            showLoaderDialog(context, "Logging you out ...");

                            LoadingComponent();  

                            SharedPreferences prefs = await SharedPreferences.getInstance();

                            //remove access token
                            await prefs.remove('accessToken');

                            //remove email
                            await prefs.remove("email");

                            //empty global loggedInUserEmail variable
                            globals.loggedInUserEmail = "";

                            // ignore: use_build_context_synchronously
                            Navigator.pushNamedAndRemoveUntil(context,LoginScreen.routeName,(route) => false);
                        },  
                      ),
                  )
              ],
            ),
          ),
          
        ),
    );
  }
}

showLoaderDialog(BuildContext context, String message){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: primaryColor,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(message,
            style: TextStyle(fontFamily: 'Poppins-Regular', color: primaryColor), )
            ),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
}