import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/models/ordermodel.dart';

class OrderDetailScreen extends StatefulWidget {
  final Ordermodel order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/cartb.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  'Order Detail',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 42,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // order detail
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 335,
              height: 153,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 336,
                        height: 154,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFFEFF0F2)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 13,
                              top: 9,
                              child: Container(
                                width: 78,
                                height: 78,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Color(0xFFBCC5FF),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 10,
                                      top: 5,
                                      child: Image.network(
                                        widget.order.productImages,
                                        width: 58,
                                        height: 67,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 101,
                              top: 14,
                              child: SizedBox(
                                width: 216,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                widget.order.productName,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.5,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              widget.order.category,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5,
                                                color: Color(0xFF7F808C),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "\$${widget.order.productPrice.toStringAsFixed(2)}",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5,
                                                color: Colors.pink,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 120,
                              left: 13,
                              child: Container(
                                height: 25,
                                width: 95,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color:
                                      widget.order.delivered == true
                                          ? Color(0xFF3C55EF)
                                          : widget.order.processing == true
                                          ? Colors.purple
                                          : Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 6,
                                      top: 3,
                                      child: Text(
                                        widget.order.delivered == true
                                            ? "Delivered"
                                            : widget.order.processing == true
                                            ? "On Process"
                                            : "Canceled",

                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // address widget
          Container(
            width: 335,
            height: widget.order.delivered == true ? 180 : 180,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFEFF0F2)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Delivery Address",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.order.state,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          letterSpacing: 1.3,
                        ),
                      ),
                      Text(
                        'To : ${widget.order.fullName.toUpperCase()}',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          letterSpacing: 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Order id: ${widget.order.id}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          letterSpacing: 1.3,
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                widget.order.delivered == true
                    ? TextButton(
                      onPressed: () {},
                      child: Text(
                        'Leave a Review',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          letterSpacing: 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
