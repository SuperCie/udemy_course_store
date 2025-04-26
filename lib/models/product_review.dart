import 'dart:convert';

import 'package:les_store_app/models/productmodel.dart';

class ProductReview {
  final String id;
  final String buyerId;
  final String email;
  final String buyerName;
  final String orderId;
  final String productId;
  final double rating;
  final String review;

  ProductReview({
    required this.id,
    required this.buyerId,
    required this.email,
    required this.buyerName,
    required this.orderId,
    required this.productId,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'buyerId': buyerId,
      'email': email,
      'buyerName': buyerName,
      'orderId': orderId,
      'productId': productId,
      'rating': rating,
      'review': review,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory ProductReview.fromJson(Map<String, dynamic> map) {
    return ProductReview(
      id: map['_id'],
      buyerId: map['buyerId'],
      email: map['email'],
      buyerName: map['buyerName'],
      orderId: map['orderId'],
      productId: map['productId'],
      rating: map['rating'],
      review: map['review'],
    );
  }
}
