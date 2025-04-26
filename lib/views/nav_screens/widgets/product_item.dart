import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/models/productmodel.dart';
import 'package:les_store_app/provider/cart_provider.dart';
import 'package:les_store_app/provider/wishlist_provider.dart';
import 'package:les_store_app/services/http_response.dart';
import 'package:les_store_app/views/detail/screen/product_detail_screen.dart';

class ProductItem extends ConsumerStatefulWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  ConsumerState<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends ConsumerState<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final wishProvider = ref.read(wishlistProvider.notifier);
    final wishData = ref.watch(wishlistProvider);
    final isInWishlist = wishData.containsKey(widget.product.id);

    final cartDataProvider = ref.read(cartProvider.notifier);
    final isInCart = wishData.containsKey(widget.product.id);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ProductDetailScreen(product: widget.product),
            ),
          );
        },
        child: Container(
          width: 170,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(color: Color(0xffF2F2F2)),
                child: Stack(
                  children: [
                    Image.network(
                      widget.product.images[0],
                      height: 170,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 15,
                      right: 2,
                      child: IconButton(
                        onPressed: () {
                          isInWishlist == true
                              ? wishProvider.removeWish(widget.product.id)
                              : wishProvider.addWish(
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
                            isInWishlist == true
                                ? "Remove from wishlist"
                                : "Added to Wishlish",
                          );
                        },
                        icon:
                            isInWishlist == true
                                ? Icon(Icons.favorite, color: Colors.pink)
                                : Icon(Icons.favorite_border),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 2,
                      child: InkWell(
                        onTap:
                            isInCart
                                ? null
                                : () {
                                  cartDataProvider.addProductToCart(
                                    productName: widget.product.productName,
                                    productPrice: widget.product.productPrice,
                                    productId: widget.product.id,
                                    productDescription:
                                        widget.product.description,
                                    category: widget.product.category,
                                    images: widget.product.images,
                                    vendorId: widget.product.sellerId,
                                    productQuantity: widget.product.quantity,
                                    quantity: 1,
                                    vendorName: widget.product.sellerName,
                                  );
                                  showBar(
                                    context,
                                    isInWishlist == true
                                        ? "Remove from cart"
                                        : "Added to cart",
                                  );
                                },
                        child: Image.asset(
                          'assets/icons/cart.png',
                          height: 26,
                          width: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.product.productName,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              widget.product.averageRatings == 0.0
                  ? SizedBox()
                  : Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 12),
                      SizedBox(width: 4),
                      Text(
                        widget.product.averageRatings.toStringAsFixed(1),
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
              Text(
                widget.product.category,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff868D94),
                ),
              ),
              Text(
                '\$${widget.product.productPrice.toStringAsFixed(2)}',
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
