import 'dart:convert';

class SubcategoryModel {
  final String id;
  final String categoryId;
  final String categoryName;
  final String image;
  final String subCategoryName;

  SubcategoryModel({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.image,
    required this.subCategoryName,
  });

  // convert to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "categoryId": categoryId,
      "categoryName": categoryName,
      "image": image,
      "subCategoryName": subCategoryName,
    };
  }

  String toJson() => json.encode(toMap());

  factory SubcategoryModel.fromJson(Map<String, dynamic> map) {
    return SubcategoryModel(
      id: map['_id'] as String,
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      image: map['image'] as String,
      subCategoryName: map['subCategoryName'] as String,
    );
  }
}
