import 'package:flutter/material.dart';
import 'package:fnf_fitness/screens/daily_exercise_screen_female.dart';

import 'package:fnf_fitness/screens/daily_exercise_screen_male.dart';

class DailyExerciseSelect extends StatefulWidget {
  const DailyExerciseSelect({super.key});

  @override
  State<DailyExerciseSelect> createState() => _DailyExerciseSelectState();
}

class _DailyExerciseSelectState extends State<DailyExerciseSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Exercise"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DailyExerciseMale()),
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
                      builder: (context) => DailyExerciseFemale()),
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
