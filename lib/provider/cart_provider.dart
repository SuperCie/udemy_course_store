import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/models/cartmodel.dart';

/*-------------------------------------------------------------------------
 A notifier class to manage the cart state and extending statenotifier
 with an inital state of an empty map
*/
class CartProvider extends StateNotifier<Map<String, Cartmodel>> {
  CartProvider() : super({});

  // method to add the product
  void addProductToCart({
    required String productName,
    required int productPrice,
    required String productId,
    required String productDescription,
    required String category,
    required List<String> images,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String vendorName,
  }) {
    // check if the product is already in the cart
    if (state.containsKey(productId)) {
      // if the product is already in the cart, update its quantity and maybe other detail
      state = {
        ...state,
        productId: Cartmodel(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          productId: state[productId]!.productId,
          productDescription: state[productId]!.productDescription,
          category: state[productId]!.category,
          images: state[productId]!.images,
          vendorId: state[productId]!.vendorId,
          productQuantity: state[productId]!.productQuantity,
          quantity: state[productId]!.quantity + 1,
          vendorName: state[productId]!.vendorName,
        ),
      };
    } else {
      // if the product is not in the cart, then add it with the provided details
      state = {
        ...state,
        productId: Cartmodel(
          productName: productName,
          productPrice: productPrice,
          productId: productId,
          productDescription: productDescription,
          category: category,
          images: images,
          vendorId: vendorId,
          productQuantity: productQuantity,
          quantity: quantity,
          vendorName: vendorName,
        ),
      };
    }
  }

  // method to increment and decrement the quantity of product
  void incrementQuantity(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;

      //notify listener that the state has changed
      state = {...state};
    }
  }

  void degrementQuantity(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;

      //notify listener
      state = {...state};
    }
  }

  // method to remove item from the cart
  void removeCartItem(String productId) {
    state.remove(productId);
    //notify listener
    state = {...state};
  }

  // method to calculate total amount item in cart
  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }

  // getter method
  Map<String, Cartmodel> get getCartItem => state;
}

// export to make it accessible within our app
final cartProvider =
    StateNotifierProvider<CartProvider, Map<String, Cartmodel>>(
      (ref) => CartProvider(),
    );
