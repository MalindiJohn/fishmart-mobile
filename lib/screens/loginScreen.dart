// import 'dart:html';


import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/authTopView.dart';
import '../components/decoratedButton.dart';
import '../components/decorated_input.dart';
import '../components/loadingComponent.dart';
import '../constants/colors.dart';
import '../services/networkOperations.dart';

import '/globals.dart' as globals;
import 'homeScreen.dart';
import 'registerScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static  String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //define form key
  //used for form validation
  final GlobalKey<FormState> __formKey = GlobalKey<FormState>();

  //define email and password controllers
  //hold the data from user input
  var emailController = TextEditingController();
  var passwordController = new TextEditingController();

  late bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const TopViewWidget(heading: "User Login", flex: 1, childView: true, authPage: true, authType: "login",),
                const AuthTopViewWidget(heading: "User Login", flex: 1),

                Expanded(
                 flex: 3,
                 child: SingleChildScrollView(
                   child: Container(
                     margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Please, login to continue.",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Poppins-Medium",
                                ),
                          ),

                          Divider(),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: __formKey,
                                child: Column(
                                  children: [
                                    DecoratedInputBox(
                                      controller: emailController,
                                      hintText: "Enter your email address",
                                      inputType: TextInputType.emailAddress,
                                      secureText: false,
                                      label: "Email Address",
                                      icon: const Icon(MaterialCommunityIcons.email_outline, color: primaryColor,size: 30,),
                                      horizontalPadding: 10,
                                      verticalPadding: 10,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    DecoratedInputBox(
                                      controller: passwordController,
                                      hintText: "Enter your password",
                                      inputType: TextInputType.text,
                                      secureText: true,
                                      label: "Password",
                                      icon: const Icon(SimpleLineIcons.key, color: primaryColor, size: 25,),
                                      horizontalPadding: 10,
                                      verticalPadding: 10,
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () => {},
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0)),
                                child: const Text(
                                  "Forgot Password ?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 17, 
                                      color: dkGreyColor,
                                      fontFamily: "Poppins-Light"),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              DecoratedButton(
                                text: "Log In",
                                primaryColor: primaryColor,
                                textColor: bgColor,
                                onPressed: () async {
                                  // start loading

                                  setState(() {
                                    isLoading = true;
                                  });

                                  var loginInfo = {
                                    "email": emailController.text,
                                    "password": passwordController.text
                                  };

                                  var loginResponse = await userLogin(loginInfo);

                                  // if a token is present on the returned response
                                  if (loginResponse['token'] != null) {
                                    // store it in shared prefs, for later usage..
                                    var prefs = await SharedPreferences.getInstance();

                                    prefs.setString('accessToken', loginResponse['token']);
                                    prefs.setString('email', loginResponse['email']);

                                    //update loggedInUserEmail global variable
                                    globals.loggedInUserEmail = loginResponse['email'];

                                    // then stop loading...
                                    setState(() {
                                      isLoading = false;
                                    });

                                    // then navigate to the home screen.
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                                  }

                                  // if by any chance we have a message in the response. This means something went wrong somewhere.
                                  // either in the network connection, or incorrect login details.
                                  if (loginResponse['message'] != null) {

                                    var errorMessage = loginResponse['message'];
                                    
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                  
                                },
                                icon: Icons.login,
                              ),
                              
                              //divider here
                              SizedBox(height: 10,),
                              Divider(),
                              
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [

                                      const Text("Don't have an account ?",
                                              style: TextStyle(
                                                fontFamily: "Poppins-Regular",
                                                fontSize: 18
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: (){

                                                //navigate to register screent
                                                Navigator.pushNamedAndRemoveUntil(context, RegisterScreen.routeName, (route) => false);
                                              }, 
                                              child: const Text(
                                                    "Sign Up / Register",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 17, 
                                                        color: primaryColor,
                                                        fontFamily: "Poppins-Light"),
                                                  ),
                                              )
                                  ],
                                ),
                              ),
                              
                              
                            ],
                          )
                        ],
                      ),
                   ),
                 ),
                 ),
              ],
            ),
          ),

          isLoading ? LoadingComponent() : Container()
        ],
      ),
    );
    
  }
}