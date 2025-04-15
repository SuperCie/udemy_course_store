import 'package:flutter/material.dart';
import 'package:les_store_app/views/nav_screens/widgets/header_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(children: [HeaderBanner()])),
    );
  }
}
