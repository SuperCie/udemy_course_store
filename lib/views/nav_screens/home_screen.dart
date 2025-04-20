import 'package:flutter/material.dart';
import 'package:les_store_app/views/nav_screens/widgets/banner_widget.dart';
import 'package:les_store_app/views/nav_screens/widgets/category_items.dart';
import 'package:les_store_app/views/nav_screens/widgets/header_banner.dart';
import 'package:les_store_app/views/nav_screens/widgets/product_widget.dart';
import 'package:les_store_app/views/utilities/reuse_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderBanner(),
            BannerWidget(),
            CategoryWidget(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ReuseText(
                lefttext: 'Popular Products',
                righttext: 'View All',
              ),
            ),
            ProductWidget(),
          ],
        ),
      ),
    );
  }
}
