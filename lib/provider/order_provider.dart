import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/models/ordermodel.dart';

class OrderProvider extends StateNotifier<List<Ordermodel>> {
  OrderProvider() : super([]);

  // set the list of orders
  void setOrders(List<Ordermodel> orders) {
    state = orders;
  }
}

final orderProvider = StateNotifierProvider<OrderProvider, List<Ordermodel>>((
  ref,
) {
  return OrderProvider();
});
