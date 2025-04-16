import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/controllers/category_controller.dart';
import 'package:les_store_app/models/categorymodel.dart';
import 'package:les_store_app/views/utilities/reuse_text.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Future<List<CategoryModel>>? futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ReuseText(lefttext: 'Categories', righttext: 'View All'),
          SizedBox(height: 10),
          FutureBuilder(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No Categories Data'));
              } else {
                final categories = snapshot.data!;
                return GridView.builder(
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
                    return Column(
                      children: [
                        Image.network(
                          categoriesData.image,
                          width: 47,
                          height: 47,
                        ),
                        Text(
                          categoriesData.name,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
