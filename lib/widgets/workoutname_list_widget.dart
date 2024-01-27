import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class WorkoutList extends StatelessWidget {
  final String title;
  final String image;
  var color;

  WorkoutList(this.title, this.image, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Container(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.yeonSung(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Container(
                height: 150,
                width: 140,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                )),
          ],
        ),
      ),
    );
  }
}
