import 'package:flutter/material.dart';
import 'package:fnf_fitness/screens/daily_exercise_screen_female.dart';

import 'package:fnf_fitness/screens/daily_exercise_screen_male.dart';
import 'package:fnf_fitness/screens/fullbody_workout_female.dart';
import 'package:fnf_fitness/screens/fullbody_workout_male.dart';

class FullBodyWorkoutSelect extends StatefulWidget {
  const FullBodyWorkoutSelect({super.key});

  @override
  State<FullBodyWorkoutSelect> createState() => _FullBodyWorkoutSelectState();
}

class _FullBodyWorkoutSelectState extends State<FullBodyWorkoutSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FullBody Workout"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullBodyWorkoutMale()),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'images/profile_man.png'), // Replace with your own avatar image
              ),
            ),
            SizedBox(height: 20),
            Text("Male",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 80),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullBodyWorkoutFemale()),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'images/profile_woman.png'), // Replace with your own avatar image
              ),
            ),
            SizedBox(height: 20),
            Text("Female",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
