import 'dart:convert';

class Ordermodel {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String productId;
  final String productName;
  final String category;
  final int productPrice;
  final int quantity;
  final String productImages;
  final String buyerId;
  final String vendorId;
  final bool processing;
  final bool delivered;

  Ordermodel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.productId,
    required this.productName,
    required this.category,
    required this.productPrice,
    required this.quantity,
    required this.productImages,
    required this.buyerId,
    required this.vendorId,
    required this.processing,
    required this.delivered,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "productId": productId,
      "productName": productName,
      "productPrice": productPrice,
      "category": category,
      "quantity": quantity,
      "productImages": productImages,
      "buyerId": buyerId,
      "vendorId": vendorId,
      "processing": processing,
      "delivered": delivered,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Ordermodel.fromJson(Map<String, dynamic> map) {
    return Ordermodel(
      id: map['_id'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      locality: map['locality'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      category: map['category'] as String,
      quantity: map['quantity'] as int,
      productImages: map['productImages'] as String,
      buyerId: map['buyerId'] as String,
      vendorId: map['vendorId'] as String,
      processing: map['processing'] as bool,
      delivered: map['delivered'] as bool,
    );
  }
}
