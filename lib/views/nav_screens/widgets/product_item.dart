import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/models/productmodel.dart';
import 'package:les_store_app/views/detail/screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
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
                      product.images[0],
                      height: 170,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 15,
                      right: 2,
                      child: Image.asset(
                        'assets/icons/love.png',
                        width: 26,
                        height: 26,
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 2,
                      child: Image.asset(
                        'assets/icons/cart.png',
                        height: 26,
                        width: 26,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                product.productName,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                product.category,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff868D94),
                ),
              ),
              Text(
                '\$${product.productPrice.toStringAsFixed(2)}',
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
