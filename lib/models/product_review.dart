import 'dart:convert';

class ProductReview {
  final String id;
  final String buyerId;
  final String email;
  final String buyerName;
  final String productId;
  final double number;
  final String review;

  ProductReview({
    required this.id,
    required this.buyerId,
    required this.email,
    required this.buyerName,
    required this.productId,
    required this.number,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'buyerId': buyerId,
      'email': email,
      'buyerName': buyerName,
      'productId': productId,
      'number': number,
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
      productId: map['productId'],
      number: map['number'],
      review: map['review'],
    );
  }
}
