import 'package:flutter/material.dart';

class InnerBanner extends StatelessWidget {
  final String image;
  const InnerBanner({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.transparent,
        border: Border.all(width: 1.5),
      ),
      width: MediaQuery.of(context).size.width,
      height: 170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.network(image, fit: BoxFit.cover),
      ),
    );
  }
}
