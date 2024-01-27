import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingTitle extends StatelessWidget {
  final String title;

  const HeadingTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Flexible(
            child: Text(title,
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
