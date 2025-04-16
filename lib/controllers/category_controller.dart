import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:les_store_app/global_variables.dart';
import 'package:les_store_app/models/categorymodel.dart';

class CategoryController {
  // fetch category
  Future<List<CategoryModel>> fetchCategory() async {
    try {
      // send http get request to fetch data
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      // check the response status code data
      if (response.statusCode == 200) {
        // convert response json to dart object
        final List<dynamic> categoryData = jsonDecode(response.body);

        // convert to category object
        List<CategoryModel> categories =
            categoryData
                .map((category) => CategoryModel.fromJson(category))
                .toList();
        return categories;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
