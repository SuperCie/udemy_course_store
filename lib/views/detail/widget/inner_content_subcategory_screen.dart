import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/controllers/product_controller.dart';
import 'package:les_store_app/controllers/subcategory_controller.dart';
import 'package:les_store_app/models/categorymodel.dart';
import 'package:les_store_app/models/productmodel.dart';
import 'package:les_store_app/models/subcategory_model.dart';
import 'package:les_store_app/views/detail/widget/back_header.dart';
import 'package:les_store_app/views/detail/widget/inner_banner.dart';
import 'package:les_store_app/views/detail/widget/inner_tile.dart';
import 'package:les_store_app/views/nav_screens/widgets/product_item.dart';
import 'package:les_store_app/views/utilities/reuse_text.dart';

class InnerContentSubcategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const InnerContentSubcategoryScreen({super.key, required this.categoryModel});

  @override
  State<InnerContentSubcategoryScreen> createState() =>
      _InnerCategoryscreenState();
}

class _InnerCategoryscreenState extends State<InnerContentSubcategoryScreen> {
  Future<List<SubcategoryModel>>? _futureSubCategories;
  // untuk product by category
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureSubCategories = SubcategoryController().getSubcategoryByCategoryName(
      widget.categoryModel.name,
    );
    futureProducts = ProductController().loadProductbyCategory(
      widget.categoryModel.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
        child: BackHeader(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InnerBanner(image: widget.categoryModel.banner),
              SizedBox(height: 20),

              Center(
                child: Text(
                  '${widget.categoryModel.name} Subcategory',
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 20),
              FutureBuilder(
                future: _futureSubCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No Subcategory Data'));
                  } else {
                    final widgetData = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate((widgetData.length / 7).ceil(), (
                          index,
                        ) {
                          final startData = index * 7;
                          final endData = (index + 1) * 7;

                          // create a padding wiget to add spacing arround the row
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children:
                                  widgetData
                                      .sublist(
                                        startData,
                                        endData > widgetData.length
                                            ? widgetData.length
                                            : endData,
                                      )
                                      .map(
                                        (subcategoryData) => InnerTile(
                                          images: subcategoryData.image,
                                          name: subcategoryData.subCategoryName,
                                        ),
                                      )
                                      .toList(),
                            ),
                          );
                        }),
                      ),
                    );
                  }
                },
              ),

              ReuseText(lefttext: 'Popular Products', righttext: 'View All'),
              FutureBuilder(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No Popular Products'));
                  } else {
                    final popularProducts = snapshot.data!;
                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularProducts.length,
                        itemBuilder: (context, index) {
                          final products = popularProducts[index];
                          return ProductItem(product: products);
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
