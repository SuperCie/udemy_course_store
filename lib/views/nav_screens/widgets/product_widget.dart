import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/controllers/product_controller.dart';
import 'package:les_store_app/provider/product_provider.dart';
import 'package:les_store_app/views/nav_screens/widgets/product_item.dart';

class ProductWidget extends ConsumerStatefulWidget {
  const ProductWidget({super.key});

  @override
  ConsumerState<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends ConsumerState<ProductWidget> {
  final ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    futureProduct();
  }

  // make use the future popular method
  Future<void> futureProduct() async {
    try {
      final products = await productController.fetchPopularProduct();

      ref.read(productProvider.notifier).setProducts(products);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final popularProducts = ref.watch(productProvider);
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
}
