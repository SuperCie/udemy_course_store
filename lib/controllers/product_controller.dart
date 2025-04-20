import 'dart:convert';

import 'package:les_store_app/global_variables.dart';
import 'package:les_store_app/models/productmodel.dart';
import 'package:http/http.dart' as http;

class ProductController {
  //Define a function that return a future containing list of the product objects
  Future<List<Product>> fetchPopularProduct() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/popular-product'),
        headers: <String, String>{
          // set the http headers for the request, specifying that the content type is json with UTF-8 encoding
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      // check if the http response status code is 200 or means successfull
      if (response.statusCode == 200) {
        print(response.body);
        // decode the json data from http
        final List<dynamic> jsonData =
            json.decode(response.body) as List<dynamic>;
        // map each items in the list to product model object which we can use it later
        List<Product> products =
            jsonData
                .map(
                  (product) =>
                      Product.fromJson(product as Map<String, dynamic>),
                )
                .toList();

        return products;
      } else {
        // if status code is not 200, throw an exeception
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      print(e);
      // if progress is failure(cant try to process)
      throw Exception('error : $e');
    }
  }

  // get data
  Future<List<Product>> loadProductbyCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$category'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        List<Product> products =
            data
                .map(
                  (productbyCategory) => Product.fromJson(
                    productbyCategory as Map<String, dynamic>,
                  ),
                )
                .toList();

        return products;
      } else {
        // if status code is not 200, throw an exeception
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      // if progress is failure(cant try to process)
      throw Exception('error : $e');
    }
  }
}
