import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:les_store_app/global_variables.dart';
import 'package:les_store_app/models/product_review.dart';
import 'package:les_store_app/services/http_response.dart';

class ProductreviewController {
  uploadReview({
    required String buyerId,
    required String email,
    required String buyerName,
    required String orderId,
    required String productId,
    required double rating,
    required String review,
    required context,
  }) async {
    try {
      final ProductReview productReview = ProductReview(
        id: '',
        buyerId: buyerId,
        email: email,
        buyerName: buyerName,
        orderId: orderId,
        productId: productId,
        rating: rating,
        review: review,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/product-review'),
        body: productReview.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");
      manageHttp(
        response: response,
        context: context,
        onSuccess: () {
          showBar(context, 'Added a review');
        },
      );
    } catch (e) {
      print(e.toString());
      showBar(context, e.toString());
    }
  }
}
