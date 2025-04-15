import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:les_store_app/global_variables.dart';
import 'package:les_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:les_store_app/services/http_response.dart';
import 'package:les_store_app/views/main_screen.dart';

class AuthController {
  // signup function
  Future<void> signUpUser({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(), // convert user data object to json for the request
        headers: <String, String>{
          // set the Headers for the request
          "Content-Type":
              'application/json; charset=UTF-8', // specify the context type as a Json
        },
      );
      manageHttp(
        response: response,
        context: context,
        onSuccess: () {
          showBar(context, 'Account created');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showBar(context, 'error: $e');
    }
  }

  //sign in function
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email':
              email, // berdasarkan kepada bagian auth.js hanya menrima email dan password
          'password': password,
        }),
        headers: <String, String>{
          // set the header
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // handle the response by using managehttp on http_response.dart
      manageHttp(
        response: response,
        context: context,
        onSuccess: () {
          showBar(context, 'Welcome back');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showBar(context, 'error: $e');
    }
  }
}
