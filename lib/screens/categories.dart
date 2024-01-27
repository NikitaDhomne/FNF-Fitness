import 'package:flutter/material.dart';
import 'package:fnf_fitness/screens/abs_list.dart';
import 'package:fnf_fitness/screens/arms_list.dart';
import 'package:fnf_fitness/screens/back_list.dart';
import 'package:fnf_fitness/screens/belly_list.dart';
import 'package:fnf_fitness/screens/butt_list.dart';
import 'package:fnf_fitness/screens/fullbody_workout.dart';
import 'package:fnf_fitness/screens/fullbody_workout_female.dart';
import 'package:fnf_fitness/screens/legs_list.dart';
import 'package:fnf_fitness/screens/thighs_list.dart';

import 'package:fnf_fitness/screens/weightgain_list.dart';
import 'package:fnf_fitness/screens/weightloss_list.dart';
import 'package:fnf_fitness/widgets/heading_home_title.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/target_area_model.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    int selectedvalue;

    var targetAreaList = [
      TargetArea(title: 'WeightGain', image: 'images/weight_gain.png', id: 1),
      TargetArea(title: 'WeightLoss', image: 'images/weight_loss.png', id: 2),
      TargetArea(title: 'FullBody', image: 'images/cardio.png', id: 3),
      TargetArea(title: 'Legs', image: 'images/warmup.png', id: 4),
      TargetArea(title: 'Butt', image: 'images/butt.png', id: 5),
      TargetArea(title: 'Thighs', image: 'images/thighs.png', id: 6),
      TargetArea(title: 'Arms', image: 'images/arm.png', id: 7),
      TargetArea(title: 'Belly', image: 'images/belly.png', id: 8),
      TargetArea(title: 'Back', image: 'images/back.png', id: 9),
      TargetArea(title: 'Abs', image: 'images/abs.png', id: 10),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Categories'),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
          height: screenHeight * 0.9,
          child: Column(
            children: [
              HeadingTitle(title: 'Target Area'),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: screenWidth * 0.24,
                        mainAxisSpacing: screenHeight * 0.03,
                        mainAxisExtent: screenHeight * 0.2),
                    itemCount: targetAreaList.length,
                    itemBuilder: ((context, index) => GestureDetector(
                          onTap: () {
                            selectedvalue = targetAreaList[index].id;
                            navigateToNewScreen(selectedvalue, context);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      AssetImage(targetAreaList[index].image),
                                ),
                                Text(
                                  targetAreaList[index].title,
                                  style: GoogleFonts.gabriela(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ))),
              ),
            ],
          )),
    );
  }

  void navigateToNewScreen(int id, BuildContext context) {
    switch (id) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WeightGain()),
        );
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WeightLoss()),
        );
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FullBodyWorkoutSelect()),
        );
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Legs()),
        );
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Butt()),
        );
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Thighs()),
        );
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Arms()),
        );
      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Belly()),
        );
      case 9:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Back()),
        );
      case 10:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Abs()),
        );
    }
  }
}
