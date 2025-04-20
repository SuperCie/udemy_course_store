import 'dart:convert';

import 'package:les_store_app/models/subcategory_model.dart';
import 'package:http/http.dart' as http;
import 'package:les_store_app/global_variables.dart';

class SubcategoryController {
  //fetch data

  Future<List<SubcategoryModel>> getSubcategoryByCategoryName(
    String categoryName,
  ) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/category/$categoryName/subcategories"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      // check the response status code data
      if (response.statusCode == 200) {
        // convert response json to dart object
        final List<dynamic> subCategoryData = jsonDecode(response.body);

        if (subCategoryData.isNotEmpty) {
          // convert to category object
          return subCategoryData
              .map((subcategory) => SubcategoryModel.fromJson(subcategory))
              .toList();
        } else {
          print("Subcategories not found");
          return [];
        }
      } else if (response.statusCode == 404) {
        print("subcategories not found");
        return [];
      } else {
        print("Cant get data");
        return [];
      }
    } catch (e) {
      print('Error fetching data : $e');
      return [];
    }
  }
}
