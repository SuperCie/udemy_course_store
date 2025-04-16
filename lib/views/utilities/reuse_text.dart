import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReuseText extends StatelessWidget {
  final String lefttext;
  final String righttext;
  const ReuseText({super.key, required this.lefttext, required this.righttext});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lefttext,
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          righttext,
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }
}
