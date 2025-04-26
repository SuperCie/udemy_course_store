import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/models/wishlistmodel.dart';

class WishlistProvider extends StateNotifier<Map<String, Wishlistmodel>> {
  WishlistProvider() : super({});

  void addWish({
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
    try {
      state[productId] = Wishlistmodel(
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
      );

      //notify listeners that the state has changed
      state = {...state};
    } catch (e) {
      print(e.toString());
    }
  }

  void removeWish(String productId) {
    state.remove(productId);
    //notify listener
    state = {...state};
  }

  Map<String, Wishlistmodel> get getWishItem => state;
}

final wishlistProvider =
    StateNotifierProvider<WishlistProvider, Map<String, Wishlistmodel>>((ref) {
      return WishlistProvider();
    });
