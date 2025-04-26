import 'package:flutter/material.dart';
import 'package:les_store_app/models/categorymodel.dart';
import 'package:les_store_app/views/detail/widget/back_header.dart';
import 'package:les_store_app/views/detail/widget/inner_content_subcategory_screen.dart';
import 'package:les_store_app/views/nav_screens/account_screen.dart';
import 'package:les_store_app/views/nav_screens/cart_screen.dart';
import 'package:les_store_app/views/nav_screens/category_screen.dart';
import 'package:les_store_app/views/nav_screens/wishlist_screen.dart';
import 'package:les_store_app/views/nav_screens/store_screen.dart';

class InnerCategoryscreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const InnerCategoryscreen({super.key, required this.categoryModel});

  @override
  State<InnerCategoryscreen> createState() => _InnerCategoryscreenState();
}

class _InnerCategoryscreenState extends State<InnerCategoryscreen> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      InnerContentSubcategoryScreen(categoryModel: widget.categoryModel),
      WishlistScreen(),
      CategoryScreen(),
      StoreScreen(),
      CartScreen(),
      AccountScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png', width: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/love.png', width: 30),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/category.png', width: 30),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/mart.png', width: 30),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/cart.png', width: 30),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/user.png', width: 30),
            label: 'Account',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
