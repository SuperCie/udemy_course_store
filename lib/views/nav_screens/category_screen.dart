import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:les_store_app/controllers/category_controller.dart';
import 'package:les_store_app/models/categorymodel.dart';
import 'package:les_store_app/views/nav_screens/widgets/header_banner.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryModel? _selectedCategory;
  Future<List<CategoryModel>>? futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
        child: HeaderBanner(),
      ),
      body: Row(
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
                    ? Column(
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
                      ],
                    )
                    : Container(),
          ),
        ],
      ),
    );
  }
}
