import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerTile extends StatelessWidget {
  final String images;
  final String name;
  const InnerTile({super.key, required this.images, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(images, fit: BoxFit.fill),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
