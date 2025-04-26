import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void manageHttp({
  required http.Response response, // response from the request
  required BuildContext context, // show snackbar
  required VoidCallback onSuccess, // if it is a successful response
}) {
  // switch statement to handle different http status codes
  switch (response.statusCode) {
    case 200: // status code 200 indicates a successfull request
      onSuccess();
      Navigator.pop(context);

      break;
    case 201:
      onSuccess();
      Navigator.pop(context);

      break;
    case 400: // status code 400 indicates user error request/bad request
      showBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500: // status code 500 indicates server error
      showBar(context, jsonDecode(response.body)['error']);
      break;
  }
}

void showBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.grey,
      margin: EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
      duration: Duration(seconds: 1),
    ),
  );
}
