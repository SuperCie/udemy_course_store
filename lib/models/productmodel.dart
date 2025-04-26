import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final int productPrice;
  final int quantity;
  final String description;
  final String category;
  final String subCategory;
  final List<String> images;
  final String sellerId;
  final String sellerName;
  final double averageRatings;
  final int totalRatings;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.images,
    required this.sellerId,
    required this.sellerName,
    required this.averageRatings,
    required this.totalRatings,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "productName": productName,
      "productPrice": productPrice,
      "quantity": quantity,
      "description": description,
      "category": category,
      "subCategory": subCategory,
      "images": images,
      "sellerId": sellerId,
      "sellerName": sellerName,
      "averageRatings": averageRatings,
      "totalRatings": totalRatings,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      quantity: map['quantity'] as int,
      description: map['description'] as String,
      category: map['category'] as String,
      subCategory: map['subCategory'] as String,
      images: List<String>.from((map['images'] as List<dynamic>)),
      sellerId: map['sellerId'] as String,
      sellerName: map['sellerName'] as String,
      averageRatings:
          (map['averageRatings'] is int
              ? (map['averageRatings'] as int).toDouble()
              : map['averageRatings']
                  as double), // untuk menjaga jika data yang dikirimkan dari json itu adalah int
      totalRatings: map['totalRatings'] as int,
    );
  }
}
