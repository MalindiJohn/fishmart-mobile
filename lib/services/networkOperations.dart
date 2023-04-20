import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String serverUrl = "fishmart-api-production.up.railway.app";

//users & members endpoints
const String loginUrl = "/api/auth/login";
const String registerUrl = "/api/auth/register";
const String memberProfile = "/api/members/profile/";
const String fetchUser = "/api/users/:email";

//tips endpoints
const String fishfarmInfoUrl = "/api/fishinfo/all";
const String singleFishfarmInfoUrl = "/api/fishinfo/";

// The future of registration....
// Cool stuff..
Future<dynamic> userLogin(Map<String, String> loginInfo) async {
  var uri = Uri.https(serverUrl, loginUrl);
  var loginRequest = await http.post(uri,
      body: jsonEncode(loginInfo),
      headers: {'Content-Type': 'application/json; charset=UTF-8'});

  // assuming we go a positive response
  if (loginRequest.statusCode == 200) {
    // everything is okay
    print(loginRequest.body);
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
  var uri = Uri.https(serverUrl, registerUrl);

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

Future<dynamic> getFishFarmingInfo() async {
  var url = Uri.https(serverUrl, fishfarmInfoUrl);

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

Future<dynamic> getSingleFishInfo(id) async {
  var url = Uri.https(serverUrl, singleFishfarmInfoUrl+id);

  var singleFishInfoResponse = await http.get(url,
     headers: {'Content-Type': 'application/json;'}
    );

  if (singleFishInfoResponse != null) {
    if (singleFishInfoResponse.statusCode == 200) {
      
      // print(jsonDecode(singleFishInfoResponse.body));

      return jsonDecode(singleFishInfoResponse.body);

    } else {
      // print(singleFishInfoResponse.statusCode);
      // throw Exception('Failed to load the Featured Tip');
    }
  } else {
    throw Exception(
        'Failed to connect to the server!!! Kindly check your Internet connection');
  }
}

// Future<dynamic> getPremiumTips() async {
//   var url = Uri.http(serverUrl, premiumTipsUrl);

//   //get token of logged in user
//   var prefs = await SharedPreferences.getInstance();
//   var token = prefs.getString('accessToken');

//   // attempt to get the tips from the repository
//   var tipsResponse = await http.get(
//     url, 
//     headers: {
//       'Content-Type': 'application/json;',
//       'Authorization': 'Bearer $token'
//       }
//     );

//   if (tipsResponse.statusCode == 200) {

//     return jsonDecode(tipsResponse.body);

//   } else {
//     var error = '{"message": "Sorry, check your connection"}';
//     return jsonDecode(error);
//   }
// }

// Future<dynamic> getArchivedTips() async {
//   var url = Uri.http(serverUrl, archiveTipsUrls);

//   var tipsResponse = await http.get(url);

//   if (tipsResponse.statusCode == 200) {

//     return jsonDecode(tipsResponse.body);

//   } else {
//     return jsonDecode("{'message': 'an error occurred'}");
//   }
// }


Future<dynamic> getLoggedInMember() async {
  // assuming the user is already logged in, we should have a token
  // anyway, we don't even get to use this piece of code. what a waste.
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('accessToken');
  var email = prefs.getString("email");

  var memberInfo = {
    "email": email
  };

  // print(memberInfo);

  var uri = Uri.https(serverUrl, memberProfile);
  var profileRequest = await http.post(uri,
      body: jsonEncode(memberInfo), 
      headers: {'Content-Type': 'application/json; charset=UTF-8'}
      );

  print(jsonDecode(profileRequest.body));

  return jsonDecode(profileRequest.body);
}