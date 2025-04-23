import 'dart:convert';

import 'package:les_store_app/global_variables.dart';
import 'package:les_store_app/models/ordermodel.dart';
import 'package:http/http.dart' as http;
import 'package:les_store_app/services/http_response.dart';

class Ordercontroller {
  //upload order
  Future<void> uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required int productPrice,
    required String category,
    required int quantity,
    required String productImages,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
    required context,
  }) async {
    try {
      final Ordermodel order = Ordermodel(
        id: id,
        fullName: fullName,
        email: email,
        state: state,
        city: city,
        locality: locality,
        productName: productName,
        productPrice: productPrice,
        category: category,
        quantity: quantity,
        productImages: productImages,
        buyerId: buyerId,
        vendorId: vendorId,
        processing: processing,
        delivered: delivered,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/orders'),
        body: order.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      manageHttp(
        response: response,
        context: context,
        onSuccess: () {
          showBar(context, 'Order placed successfully, Thankyou');
          print(response.body);
        },
      );
    } catch (e) {
      showBar(context, e.toString());
      print(e.toString());
    }
  }

  // get API
  Future<List<Ordermodel>> loadOrdersData({required String buyerId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders/$buyerId'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // parse the json response body into dynamic list
        // convert the jsondata into a formate that can further processed in dart
        final List<dynamic> jsonData = jsonDecode(response.body);
        // map the dynamic list to list of orders objet using the fromjson factory method
        // this step converts the raw data into list of the orders instances, which are easir to work with
        List<Ordermodel> orders =
            jsonData.map((data) => Ordermodel.fromJson(data)).toList();

        return orders;
      } else {
        //throw exception if the server responded with an error
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error load data : $e');
    }
  }
}
