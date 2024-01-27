import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fnf_fitness/screens/tenminutes_exercise.dart';

class TenMinutesWorkoutDetail extends StatefulWidget {
  const TenMinutesWorkoutDetail({super.key});

  @override
  State<TenMinutesWorkoutDetail> createState() =>
      _TenMinutesWorkoutDetailState();
}

class _TenMinutesWorkoutDetailState extends State<TenMinutesWorkoutDetail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List<WarmUpModel> warmUpList = [
  //   WarmUpModel(
  //       title: "Jumping Jacks",
  //       image: "images/warmup_gif.gif",
  //       process:
  //           "Start with feet together, arms at sides. Jump, spreading legs and raising arms overhead. "),
  //   WarmUpModel(
  //       title: "High Knees",
  //       image: "images/high_knees.gif",
  //       process:
  //           "Stand in place, jog, bringing knees up toward chest. Engage core for balance."),
  //   WarmUpModel(
  //       title: "Arm Circles",
  //       image: "images/arm_circles.gif",
  //       process:
  //           "Extend arms to sides, make small circles. 30s clockwise, 30s counterclockwise."),
  //   WarmUpModel(
  //       title: "Hip Circles",
  //       image: "images/hip_circles.gif",
  //       process:
  //           "Place hands on hips, rotate in circular motion. 30s each direction.Stand in place, jog, bringing knees up toward chest. Engage core for balance."),
  //   WarmUpModel(
  //       title: "Bodyweight Squats",
  //       image: "images/bodyweight_squat.gif",
  //       process:
  //           "Stand shoulder-width apart, bend knees, lower hips as if sitting back into a chair."),
  //   WarmUpModel(
  //       title: "Lunges",
  //       image: "images/lunges.gif",
  //       process:
  //           "Stand tall, step forward with one leg, lower body until both knees form right angles. Push through the front heel, return to starting position, and alternate legs."),
  //   WarmUpModel(
  //       title: "Dynamic Arm Swings",
  //       image: "images/dynamic_arm_swing.gif",
  //       process: "Swing arms forward and backward."),
  //   WarmUpModel(
  //       title: "March In Place",
  //       image: "images/march_in_place.gif",
  //       process: "Lift knees high while marching. Engage core for balance."),
  //   WarmUpModel(
  //       title: "Torso Twists",
  //       image: "images/torso_twist.gif",
  //       process:
  //           "Stand with feet shoulder-width apart, twist torso side to side."),
  //   WarmUpModel(
  //       title: "Butt Kicks",
  //       image: "images/butt_kicks.gif",
  //       process: "Jog in place, kicking heels up towards glutes."),
  // ];

  late Future<QuerySnapshot<Map<String, dynamic>>> data;

  @override
  void initState() {
    super.initState();
    // Initialize the future when the widget is created
    data = FirebaseFirestore.instance.collection('WarmUp').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10 Minutes Workout"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            // Access data from the snapshot
            final data = snapshot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                // Access individual document fields
                final document = data[index];
                final title = document['title'];

                final gifUrl = document['gifUrl'];
                final des1 = document['des1'];
                final des2 = document['des2'];
                final des3 = document['des3'];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TenMinustesExercise(
                                  title: title,
                                  gifUrl: gifUrl,
                                  des1: des1,
                                  des2: des2,
                                  des3: des3,
                                )));
                  },
                  child: Card(
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '$title',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Image.network('$gifUrl'),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
