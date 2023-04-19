import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String serverUrl = "141.95.31.203:3000";

//users & members endpoints
const String loginUrl = "/api/auth/login";
const String registerUrl = "/api/auth/register";
const String memberProfile = "/api/members/profile/";
const String makeVip = "/api/members/makevip/";
const String revokeVip = "/api/members/revokevip/:id";
const String fetchUser = "/api/users/:email";

//tips endpoints
const String freeTipsUrl = "/api/tips/free";
const String premiumTipsUrl = "/api/tips/premium";
const String archiveTipsUrls = "/api/tips/closed/archives";

// The future of registration....
// Cool stuff..
Future<dynamic> userLogin(Map<String, String> loginInfo) async {
  var uri = Uri.http(serverUrl, loginUrl);
  var loginRequest = await http.post(uri,
      body: jsonEncode(loginInfo),
      headers: {'Content-Type': 'application/json; charset=UTF-8'});

  // assuming we go a positive response
  if (loginRequest.statusCode == 200) {
    // everything is okay
    return jsonDecode(loginRequest.body);
    
  } else if (loginRequest.statusCode == 404) {
    // if a status code 404 is returned,
    // 404 implies that the given user is not found.
    var incorrectLoginInfo = jsonDecode(loginRequest.body);
    return incorrectLoginInfo;
  } else {
    // something bad has really happened, possibly on the server side I guess..
    var errorMessage = '{"message": "Network Error, try again"}';
    return jsonDecode(errorMessage);
  }
}

// On to the other alternate future, the future of Registration.
Future<dynamic> userRegistration(Map<String, String> registrationInfo) async {
  var uri = Uri.http(serverUrl, registerUrl);

  var registrationResponse = await http.post(uri,
      body: jsonEncode(registrationInfo),
      headers: {'Content-Type': 'application/json; charset=UTF-8'});

  if (registrationResponse.statusCode == 200) {
    // implies that a user was successfully registered.
    return jsonDecode(registrationResponse.body);
    
  } else {
    // something went wrong somewhere, maybe in the user input I believe, or the server maybe
    var errorMessage = '{"message": "${registrationResponse.reasonPhrase}"}';
    return jsonDecode(errorMessage);
    // print(jsonEncode(registrationInfo));
  }
}

Future<dynamic> getFreeTips() async {
  var url = Uri.http(serverUrl, freeTipsUrl);

  var freeTipsResponse = await http.get(url,
     headers: {'Content-Type': 'application/json;'}
    );

  if (freeTipsResponse != null) {
    if (freeTipsResponse.statusCode == 200) {
      
      // print(jsonDecode(freeTipsResponse.body));

      return jsonDecode(freeTipsResponse.body);

    } else {
      // print(freeTipsResponse.statusCode);
      // throw Exception('Failed to load the Featured Tip');
    }
  } else {
    throw Exception(
        'Failed to connect to the server!!! Kindly check your Internet connection');
  }
}

Future<dynamic> getPremiumTips() async {
  var url = Uri.http(serverUrl, premiumTipsUrl);

  //get token of logged in user
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('accessToken');

  // attempt to get the tips from the repository
  var tipsResponse = await http.get(
    url, 
    headers: {
      'Content-Type': 'application/json;',
      'Authorization': 'Bearer $token'
      }
    );

  if (tipsResponse.statusCode == 200) {

    return jsonDecode(tipsResponse.body);

  } else {
    var error = '{"message": "Sorry, check your connection"}';
    return jsonDecode(error);
  }
}

Future<dynamic> getArchivedTips() async {
  var url = Uri.http(serverUrl, archiveTipsUrls);

  var tipsResponse = await http.get(url);

  if (tipsResponse.statusCode == 200) {

    return jsonDecode(tipsResponse.body);

  } else {
    return jsonDecode("{'message': 'an error occurred'}");
  }
}


Future<dynamic> getLoggedInMember() async {
  // assuming the user is already logged in, we should have a token
  // anyway, we don't even get to use this piece of code. what a waste.
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('accessToken');
  var email = prefs.getString("email");

  var memberInfo = {
    "email": email
  };

  print(memberInfo);

  var uri = Uri.http(serverUrl, memberProfile);
  var profileRequest = await http.post(uri,
      body: jsonEncode(memberInfo), 
      headers: {'Content-Type': 'application/json; charset=UTF-8'}
      );

  print(jsonDecode(profileRequest.body));

  return jsonDecode(profileRequest.body);
}

Future<dynamic> makeUserVip() async {

  var prefs = await SharedPreferences.getInstance();
  // var token = prefs.getString('accessToken');
  var email = prefs.getString("email");

  var data = {
    "email": email
  };

  var uri = Uri.http(serverUrl, makeVip);
  var profileRequest = await http.post(uri,
      body: jsonEncode(data), 
      headers: {'Content-Type': 'application/json; charset=UTF-8'}
      );

  // print(jsonDecode(profileRequest.body));

  return jsonDecode(profileRequest.body);

}

Future<dynamic> removeVip(id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final String userID = id;

  final String? token = prefs.getString('winnintipsToken');

  var apiUrl = Uri.http(serverUrl, revokeVip);

  Map data = {"id": userID, "isVip": "1"};

  var body = jsonEncode(data);

  final response = await http.put(apiUrl,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body);

  if (response != null) {
    if (response.statusCode == 200) {
      final String responseString = response.body;

      return jsonDecode(responseString);
    } else {
      return jsonDecode('Login Failed!!!');
    }
  } else {
    return jsonDecode(
        'Could not connect to the server! Kindly check your internet connection');
  }
}
