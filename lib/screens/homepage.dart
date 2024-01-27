import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fnf_fitness/screens/profile.dart';
import 'package:fnf_fitness/screens/workout_video.dart';
import 'package:fnf_fitness/screens/signIn_screen.dart';

import '../models/workoutname_list_model.dart';
import '../widgets/heading_home_title.dart';
import '../widgets/workoutname_list_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  var workoutNameList = [
    WorkoutName(
        title: 'WarmUp (10 Minutes)',
        image: 'images/warmup.png',
        color: Color(0xffacddde),
        video: 'images/video/10min_workout.mp4'),
    WorkoutName(
        title: 'Daily Exercise',
        image: 'images/daily_exercise.png',
        color: Color(0xffcaf1de),
        video: 'images/video/daily_exercise.mp4'),
    WorkoutName(
        title: 'Weight Gain/Loss',
        image: 'images/weight.png',
        color: Color(0xffe1f8dc),
        video: 'images/video/30days_fitness.mp4'),
    WorkoutName(
        title: 'Full Body Workout',
        image: 'images/full_body_workout.png',
        color: Color(0xfffef8dd),
        video: 'images/video/full_body.mp4')
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Workouts Plan'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_user!.displayName.toString()),
              accountEmail: Text(_user!.email.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          HeadingTitle(title: 'Workouts'),
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkoutVideo(
                                  video: workoutNameList[0].video,
                                  title: workoutNameList[0].title,
                                )));
                  },
                  child: WorkoutList(workoutNameList[0].title,
                      workoutNameList[0].image, workoutNameList[0].color),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkoutVideo(
                                  video: workoutNameList[1].video,
                                  title: workoutNameList[1].title,
                                )));
                  },
                  child: WorkoutList(workoutNameList[1].title,
                      workoutNameList[1].image, workoutNameList[1].color),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkoutVideo(
                                  video: workoutNameList[2].video,
                                  title: workoutNameList[2].title,
                                )));
                  },
                  child: WorkoutList(workoutNameList[2].title,
                      workoutNameList[2].image, workoutNameList[2].color),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkoutVideo(
                                  video: workoutNameList[3].video,
                                  title: workoutNameList[3].title,
                                )));
                  },
                  child: WorkoutList(workoutNameList[3].title,
                      workoutNameList[3].image, workoutNameList[3].color),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
