import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes.dart';
import 'screens/homeScreen.dart';
import 'screens/loginScreen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  var prefs = await SharedPreferences.getInstance();
  // var onboard = prefs.getString("onBoarded");
  // var loggedIn = prefs.getString('accessToken');

  var loggedIn = null;

  if (loggedIn != null) {

    runApp( MyApp(loggedIn: "true"));

  } else {

    runApp( MyApp(loggedIn: null));
  }
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {

  String _loggedIn = "";

  // ignore: use_key_in_widget_constructors
  MyApp({String? loggedIn}){

    _loggedIn = loggedIn?? "null";
  }

  @override
 // ignore: no_logic_in_create_state
 _MyAppState createState() => _MyAppState(_loggedIn);
}

class _MyAppState extends State<MyApp> {

  String? userIsLoggedIn;

  _MyAppState(String loggedIn){

      userIsLoggedIn = loggedIn;

  }

  @override

  void initState(){

    super.initState();

  }

  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Fish Mart - mobile",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      initialRoute: userIsLoggedIn != "null"
        ? HomeScreen.routeName 
        : LoginScreen.routeName,
      routes: routes,  
      
    );
    
  }
}