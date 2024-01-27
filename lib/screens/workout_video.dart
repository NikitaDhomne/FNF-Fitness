import 'package:flutter/material.dart';
import 'package:fnf_fitness/screens/daily_exercise_select.dart';
import 'package:fnf_fitness/screens/weight_gain_loss.dart';
import 'package:fnf_fitness/screens/fullbody_workout.dart';
import 'package:fnf_fitness/screens/tenminutes_workout_detail.dart';

import 'package:video_player/video_player.dart';

class WorkoutVideo extends StatefulWidget {
  final String video;
  final String title;
  WorkoutVideo({super.key, required this.video, required this.title});

  @override
  State<WorkoutVideo> createState() => _WorkoutVideoState();
}

class _WorkoutVideoState extends State<WorkoutVideo> {
  late VideoPlayerController _videoPlayerController;
  bool _isPlaying = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.video)
      ..initialize().then((_) {
        _videoPlayerController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _toggleVideoPlay() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        _isPlaying = false;
      } else {
        _videoPlayerController.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
          child: _videoPlayerController.value.isInitialized
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .black45, // Set the background color here
                              shape: BoxShape
                                  .circle, // Optional: Set the shape (circle in this example)
                            ),
                            child: IconButton(
                                onPressed: _toggleVideoPlay,
                                icon: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow,
                                ),
                                color: Colors.white, // Icon color
                                iconSize: 30.0, // Adjust icon size as needed
                                padding: EdgeInsets.all(
                                    10.0), // Padding around the icon

                                tooltip: 'Play'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _videoPlayerController.pause();
                          navigateToWorkoutScreen(widget.title);
                        },
                        child: Text(
                          "Let's Start Workout",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffec9706), // Background color
                          onPrimary: Colors.white, // Text color
                        ))
                  ],
                )
              : CircularProgressIndicator()),
    );
  }

  void navigateToWorkoutScreen(String title) {
    // Replace this logic with your own navigation logic based on the video URL
    if (title.contains('WarmUp (10 Minutes)')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TenMinutesWorkoutDetail()),
      );
    } else if (title.contains('Daily Exercise')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DailyExerciseSelect()),
      );
    } else if (title.contains('Weight Gain/Loss')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeightGainLossScreen()),
      );
    } else if (title.contains('Full Body Workout')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FullBodyWorkoutSelect()),
      );
    }
  }
}
