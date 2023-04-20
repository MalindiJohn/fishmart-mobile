import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/authTopView.dart';
import '../components/decoratedButton.dart';
import '../components/decorated_input.dart';
import '../components/errorComponent.dart';
import '../components/loadingComponent.dart';
import '../constants/colors.dart';
import '../globals.dart' as globals;
import '../services/networkOperations.dart';
import 'homeScreen.dart';
import 'loginScreen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static String routeName = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  //define form key
  //used for form validation
  final GlobalKey<FormState> __formKey = GlobalKey<FormState>();

  //define email and password controllers
  //hold the data from user input
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var locationController = TextEditingController();
  var phoneNumberController = TextEditingController();

  late bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
 
       statusBarColor: primaryColor,
       
    ));

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
              children:  [

                // const TopViewWidget(heading: "Create Account", flex: 1, childView: true, authPage: true, authType: "register",),
                const AuthTopViewWidget(heading: "Create Account", flex: 1),

                Expanded(
                 flex: 3,
                 child: SingleChildScrollView(
                   child: Container(
                     margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Create an Account here.",
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
                                      controller: firstNameController,
                                      hintText: "Enter your first name",
                                      inputType: TextInputType.text,
                                      secureText: false,
                                      label: "First Name",
                                      icon: const Icon(Icons.person_outline_sharp, color: primaryColor,size: 25,),
                                      horizontalPadding: 2,
                                      verticalPadding: 2,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),DecoratedInputBox(
                                      controller: lastNameController,
                                      hintText: "Enter your last name",
                                      inputType: TextInputType.text,
                                      secureText: false,
                                      label: "Last Name",
                                      icon: const Icon(Icons.person_outline_sharp, color: primaryColor,size: 25,),
                                      horizontalPadding: 2,
                                      verticalPadding: 2,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),DecoratedInputBox(
                                      controller: emailController,
                                      hintText: "Enter your email address",
                                      inputType: TextInputType.emailAddress,
                                      secureText: false,
                                      label: "Email Address",
                                      icon: const Icon(MaterialCommunityIcons.email_outline, color: primaryColor,size: 25,),
                                      horizontalPadding: 2,
                                      verticalPadding: 2,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),DecoratedInputBox(
                                      controller: phoneNumberController,
                                      hintText: "Enter your phone number",
                                      inputType: TextInputType.phone,
                                      secureText: false,
                                      label: "Phone Number",
                                      icon: const Icon(SimpleLineIcons.phone, color: primaryColor,size: 25,),
                                      horizontalPadding: 2,
                                      verticalPadding: 2,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),DecoratedInputBox(
                                      controller: locationController,
                                      hintText: "Enter your location",
                                      inputType: TextInputType.text,
                                      secureText: false,
                                      label: "Location",
                                      icon: const Icon(EvilIcons.location, color: primaryColor,size: 25,),
                                      horizontalPadding: 2,
                                      verticalPadding: 2,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    DecoratedInputBox(
                                      controller: passwordController,
                                      hintText: "Enter your password",
                                      inputType: TextInputType.text,
                                      secureText: true,
                                      label: "Password",
                                      icon: const Icon(SimpleLineIcons.key, color: primaryColor, size: 22,),
                                      horizontalPadding: 2,
                                      verticalPadding: 2,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    DecoratedInputBox(
                                      controller: confirmPasswordController,
                                      hintText: "Enter your password",
                                      inputType: TextInputType.text,
                                      secureText: true,
                                      label: "Confirm Password",
                                      icon: const Icon(SimpleLineIcons.key, color: primaryColor, size: 22,),
                                      horizontalPadding: 2,
                                      verticalPadding: 2,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
                                height: 30,
                              ),
                              DecoratedButton(
                                text: "Create Account",
                                primaryColor: primaryColor,
                                textColor: bgColor,
                                onPressed: () async {
                                  // start loading
                                  setState(() {
                                    isLoading = true;
                                  });

                                  var registrationInfo = {
                                    "firstName": firstNameController.text,
                                    "lastName": lastNameController.text,
                                    "email": emailController.text,
                                    "telephone": phoneNumberController.text,
                                    "location": locationController.text,
                                    "password": passwordController.text,
                                  };

                                  var registrationResponse = await userRegistration(registrationInfo);

                                  // if(registrationInfo['message'] != null){

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

                                    // then navigate to the home screen, with tips and shit.
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                                  }

                                  if (loginResponse['message'] != null) {
                                    var errorMessage = loginResponse['message'];
                                    setState(() {
                                        isLoading = false;
                                    });
                                  }

                                  // } else{

                                  //   //return error component
                                  //   return const ErrorComponentWidget(errorText: "Whoops! Could not get Tips. Probably a server error. Try again later");
                                    
                                  // }
                                  
                                },
                                icon: Icons.person_add
                              ),
                              
                              //divider here
                              const SizedBox(height: 10,),
                              const Divider(),
                              
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [

                                      const Text("Already have an account ?",
                                              style: TextStyle(
                                                fontFamily: "Poppins-Regular",
                                                fontSize: 18
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: (){

                                                //navigate to register screent
                                                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                                              }, 
                                              child: const Text(
                                                    "Login here.",
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

          isLoading ? LoadingComponent() : Container(),
        ],
      ),
    );
    
  }
}