import 'package:http/http.dart' as http;
import 'package:les_store_app/global_variables.dart';
import 'package:les_store_app/models/product_review.dart';
import 'package:les_store_app/services/http_response.dart';

class ProductreviewController {
  uploadReview({
    required String buyerId,
    required String email,
    required String buyerName,
    required String productId,
    required double number,
    required String review,
    required context,
  }) async {
    try {
      final ProductReview productReview = ProductReview(
        id: '',
        buyerId: buyerId,
        email: email,
        buyerName: buyerName,
        productId: productId,
        number: number,
        review: review,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/product-review'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      manageHttp(
        response: response,
        context: context,
        onSuccess: () {
          showBar(context, 'Added a review');
        },
      );
    } catch (e) {}
  }
}
