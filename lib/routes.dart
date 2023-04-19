import 'package:fishmartmobile/screens/expensesScreen.dart';
import 'package:fishmartmobile/screens/fishFarmInfoScreen.dart';
import 'package:fishmartmobile/screens/homeScreen.dart';
import 'package:fishmartmobile/screens/loginScreen.dart';
import 'package:fishmartmobile/screens/profileScreen.dart';
import 'package:fishmartmobile/screens/registerScreen.dart';
import 'package:fishmartmobile/screens/salesScreen.dart';
import 'package:flutter/material.dart';

//routes
final Map<String, WidgetBuilder> routes = {

  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SalesScreen.routeName: (context) => const SalesScreen(),
  ExpensesScreen.routeName: (context) => const ExpensesScreen(),
  FishFarmInfoScreen.routeName: (context) => const FishFarmInfoScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen()
};