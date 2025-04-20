import 'package:flutter/material.dart';
import 'package:les_store_app/controllers/product_controller.dart';
import 'package:les_store_app/models/productmodel.dart';
import 'package:les_store_app/views/nav_screens/widgets/product_item.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final ProductController productController = ProductController();
  // future that will hold the list of popular products
  late Future<List<Product>> futurePopularProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePopularProducts = productController.fetchPopularProduct();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futurePopularProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Popular Products'));
        } else {
          final popularProducts = snapshot.data!;
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: popularProducts.length,
              itemBuilder: (context, index) {
                final products = popularProducts[index];
                return ProductItem(product: products);
              },
            ),
          );
        }
      },
    );
  }
}
