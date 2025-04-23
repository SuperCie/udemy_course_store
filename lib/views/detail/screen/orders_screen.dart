import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/controllers/ordercontroller.dart';
import 'package:les_store_app/provider/order_provider.dart';
import 'package:les_store_app/provider/user_provder.dart';
import 'package:les_store_app/views/detail/screen/order_detail_screen.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState(); // lebih bagus daripada membuat _OrdersScreenState
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  final Ordercontroller ordercontroller = Ordercontroller();

  Future<void> _fetchOrderData() async {
    final user = ref.read(
      userProvder,
    ); // gunakan ini karena kita memerlukan data id dari user
    if (user != null) {
      try {
        final orders = await ordercontroller.loadOrdersData(buyerId: user.id);
        ref.read(orderProvider.notifier).setOrders(orders);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchOrderData();
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);
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
                left: 322,
                top: 50,
                child: Stack(
                  children: [
                    Image.asset('assets/icons/not.png', width: 25, height: 25),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            orders.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  'My Orders',
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

      body:
          orders.isEmpty
              ? Center(
                child: Text(
                  'No Orders History Found',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
              : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => OrderDetailScreen(order: order),
                          ),
                        );
                      },
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
                                    border: Border.all(
                                      color: Color(0xFFEFF0F2),
                                    ),
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
                                                  order.productImages,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          order.productName,
                                                          style:
                                                              GoogleFonts.montserrat(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1.5,
                                                              ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        order.category,
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing:
                                                                  1.5,
                                                              color: Color(
                                                                0xFF7F808C,
                                                              ),
                                                            ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        "\$${order.productPrice.toStringAsFixed(2)}",
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing:
                                                                  1.5,
                                                              color:
                                                                  Colors.pink,
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
                                                order.delivered == true
                                                    ? Color(0xFF3C55EF)
                                                    : order.processing == true
                                                    ? Colors.purple
                                                    : Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                left: 6,
                                                top: 3,
                                                child: Text(
                                                  order.delivered == true
                                                      ? "Delivered"
                                                      : order.processing == true
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
                  );
                },
              ),
    );
  }
}
