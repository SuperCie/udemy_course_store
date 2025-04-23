import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:les_store_app/models/categorymodel.dart';

class CategoryProvider extends StateNotifier<List<CategoryModel>> {
  CategoryProvider() : super([]);

  void setCategory(List<CategoryModel> categories) {
    state = categories;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryProvider, List<CategoryModel>>((ref) {
      return CategoryProvider();
    });
