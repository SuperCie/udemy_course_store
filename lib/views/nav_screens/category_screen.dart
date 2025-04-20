import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/controllers/category_controller.dart';
import 'package:les_store_app/controllers/subcategory_controller.dart';
import 'package:les_store_app/models/categorymodel.dart';
import 'package:les_store_app/models/subcategory_model.dart';
import 'package:les_store_app/views/nav_screens/widgets/header_banner.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<SubcategoryModel> _subcategories = [];
  CategoryModel? _selectedCategory;
  Future<List<CategoryModel>>? futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().fetchCategory();
    // once the categories loaded, process then
    futureCategories!.then((value) {
      // iterate through the categories to find the category (autoamtically open Fashion)
      for (var category in value) {
        if (category.name == "Baby") {
          // for example
          //if Baby category is found, set the screen into a selected Baby category
          setState(() {
            _selectedCategory = category;
          });
          // load subcategories for the baby category
          _loadSubcategory(category.name);
        }
      }
    });
  }

  // load subcategory based on the categoryName
  Future<void> _loadSubcategory(String categoryName) async {
    final subcategories = await SubcategoryController()
        .getSubcategoryByCategoryName(categoryName);
    setState(() {
      _subcategories = subcategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
        child: HeaderBanner(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left UI
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              child: FutureBuilder(
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
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            _loadSubcategory(category.name);
                          },
                          title: Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  _selectedCategory == category
                                      ? Colors.blue
                                      : Colors.black,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          // right side UI
          Expanded(
            flex: 4,
            child:
                _selectedCategory != null
                    ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              _selectedCategory!.name,
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.7,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              height: 150,
                              child: Image.network(
                                _selectedCategory!.banner,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          _subcategories.isNotEmpty
                              ? GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(20),
                                shrinkWrap: true,
                                itemCount: _subcategories.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 6,
                                    ),
                                itemBuilder: (context, index) {
                                  final subcategory = _subcategories[index];
                                  return Column(
                                    children: [
                                      Container(
                                        height: 75,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                            child: Image.network(
                                              subcategory.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            subcategory.subCategoryName,
                                            style: GoogleFonts.quicksand(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.7,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                              : Center(
                                child: Text(
                                  'No Subcategories available',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        ],
                      ),
                    )
                    : Container(),
          ),
        ],
      ),
    );
  }
}
