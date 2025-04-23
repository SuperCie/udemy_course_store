import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/controllers/category_controller.dart';
import 'package:les_store_app/models/categorymodel.dart';
import 'package:les_store_app/provider/category_provider.dart';
import 'package:les_store_app/views/detail/screen/inner_categoryscreen.dart';
import 'package:les_store_app/views/utilities/reuse_text.dart';

class CategoryWidget extends ConsumerStatefulWidget {
  const CategoryWidget({super.key});

  @override
  ConsumerState<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends ConsumerState<CategoryWidget> {
  final categoryController = CategoryController();

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final categoryData = await categoryController.fetchCategory();
      ref.read(categoryProvider.notifier).setCategory(categoryData);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ReuseText(lefttext: 'Categories', righttext: 'View All'),
          SizedBox(height: 10),
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final categoriesData = categories[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => InnerCategoryscreen(
                            categoryModel: categoriesData,
                          ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Image.network(categoriesData.image, width: 47, height: 47),
                    Text(
                      categoriesData.name,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
