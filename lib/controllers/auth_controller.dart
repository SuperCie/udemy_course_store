import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/global_variables.dart';
import 'package:les_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:les_store_app/provider/user_provder.dart';
import 'package:les_store_app/services/http_response.dart';
import 'package:les_store_app/views/authentication/login_screen.dart';
import 'package:les_store_app/views/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

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
            MaterialPageRoute(builder: (context) => LoginScreen()),
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
        onSuccess: () async {
          showBar(context, 'Welcome back');
          //Access shared preferences for token and user data storage
          SharedPreferences preferences = await SharedPreferences.getInstance();

          // extract authentication token and save it to device
          String token = jsonDecode(response.body)['token'];
          // store the authentication token securely in sharedPrefences
          await preferences.setString('auth_token', token);

          // Encode the user data received from backend as json
          final userJson = jsonEncode(jsonDecode(response.body)['user']);

          // update the application state with the user data using riverpod
          providerContainer.read(userProvder.notifier).setUser(userJson);

          // store the data in sharePreference for future use
          await preferences.setString('user', userJson);

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

  //sign out
  Future<void> signOutUser({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // clear the token and user from sharedpreference
      await preferences.remove('auth_token');
      await preferences.remove('user');
      // clear the user state
      providerContainer.read(userProvder.notifier).signOut();
      // navigate the user back to the login screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
        (route) => false,
      );
      print("TOKEN after signout: ${preferences.getString('auth_token')}");
      print("USER after signout: ${preferences.getString('user')}");

      showBar(context, 'Signout successfully');
    } catch (e) {
      showBar(context, e.toString());
    }
  }

  //Update user state, city and locality
  Future<void> updateUserData({
    required context,
    required String id,
    required String state,
    required String city,
    required String locality,
  }) async {
    try {
      // make an http put request to update users state, city and locality
      http.Response response = await http.put(
        Uri.parse('$uri/api/users/$id'),
        headers: <String, String>{
          // set the header
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // encode the update data(state, city, and locality) as json object
        body: jsonEncode({'state': state, 'city': city, 'locality': locality}),
      );
      manageHttp(
        response: response,
        context: context,
        onSuccess: () async {
          // decode the updated user data from the response body (json type)
          // because we sending the data from api is json type
          final updatedUser = jsonDecode(response.body);

          //access sharedpreferences for local data storage user
          SharedPreferences preferences = await SharedPreferences.getInstance();

          //encode the update user data as json string (prepares data for storage in shared preferences)
          final userJson = jsonEncode(updatedUser);

          //update the application state wtih the updated user data using riverpod
          // this ensures the app reflects the most recent user data
          providerContainer.read(userProvder.notifier).setUser(userJson);

          // store the updated user data in sharepreference for future use
          // this allow the app to retrive the user data even if the app got restarted
          await preferences.setString('user', userJson);
        },
      );
    } catch (e) {
      showBar(context, 'error: $e');
    }
  }
}
