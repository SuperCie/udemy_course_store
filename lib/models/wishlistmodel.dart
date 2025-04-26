class Wishlistmodel {
  final String productName;
  final int productPrice;
  final String productId;
  final String productDescription;
  final String category;
  final List<String> images;
  final String vendorId;
  final int productQuantity;
  int quantity;
  final String vendorName;

  Wishlistmodel({
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.productDescription,
    required this.category,
    required this.images,
    required this.vendorId,
    required this.productQuantity,
    required this.quantity,
    required this.vendorName,
  });
}
