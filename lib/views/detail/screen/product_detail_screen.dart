import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/models/productmodel.dart';
import 'package:les_store_app/provider/cart_provider.dart';
import 'package:les_store_app/services/http_response.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.product.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Detail',
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 275,
            decoration: BoxDecoration(color: Color(0xffF2F2F2)),
            child: PageView.builder(
              itemCount: widget.product.images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.product.images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.productName,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Color(0xFF3C55Ef),
                  ),
                ),
                Text(
                  '\$${widget.product.productPrice.toStringAsFixed(0)}',
                  style: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.category,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Divider(color: Colors.black),
                Text(
                  'About',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.7,
                    color: Color(0xFF363330),
                  ),
                ),
                Text(
                  widget.product.description,
                  style: GoogleFonts.lato(fontSize: 18, letterSpacing: 2),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap:
              isInCart
                  ? null
                  : () {
                    cartProviderData.addProductToCart(
                      productName: widget.product.productName,
                      productPrice: widget.product.productPrice,
                      productId: widget.product.id,
                      productDescription: widget.product.description,
                      category: widget.product.category,
                      images: widget.product.images,
                      vendorId: widget.product.sellerId,
                      productQuantity: widget.product.quantity,
                      quantity: 1,
                      vendorName: widget.product.sellerName,
                    );
                    showBar(
                      context,
                      "${widget.product.productName} added to cart",
                    );
                    Navigator.pop(context);
                  },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isInCart ? Colors.grey : Color(0xFF3B54EE),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'Add to cart',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
