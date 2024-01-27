import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class FitnessChallengeExerciseDetailScreen extends StatefulWidget {
  final int dayNumber;
  final bool isExerciseCompleted;

  FitnessChallengeExerciseDetailScreen({
    required this.dayNumber,
    required this.isExerciseCompleted,
  });

  @override
  State<FitnessChallengeExerciseDetailScreen> createState() =>
      _FitnessChallengeExerciseDetailScreenState();
}

class _FitnessChallengeExerciseDetailScreenState
    extends State<FitnessChallengeExerciseDetailScreen> {
  late List<String> exercises;

  int currentIndex = 0;
  bool isTimerActive = true;
  int timerSeconds = 5;
  bool _isPause = true;

  late Timer _timer;
  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
    // Fetch exercises for the selected day
    exercises = getExercisesForDay(widget.dayNumber);
    startTimer();
  }

  List<String> getExercisesForDay(int dayNumber) {
    // Replace this logic with your own to fetch exercises based on the day number
    if (dayNumber == 1) {
      return ["Exercise A", "Exercise B", "Exercise C"];
    } else if (dayNumber == 2) {
      return ["Exercise X", "Exercise Y", "Exercise Z"];
    } else if (dayNumber == 3) {
      return ["Exercise 1", "Exercise 2", "Exercise 3"];
    } else {
      // Handle other days as needed
      return [];
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (timerSeconds > 0) {
        setState(() {
          timerSeconds--;
        });
      } else {
        setState(() {
          isTimerActive = false;
        });
        _timer.cancel();
      }
    });
  }

  void resetTimer() {
    setState(() {
      timerSeconds = 5;
      isTimerActive = true;
    });
    startTimer();
  }

  void moveToNextImage() {
    if (currentIndex < exercises.length - 1) {
      setState(() {
        currentIndex++;
      });
      resetTimer();
    } else {
      // Do something when all images are displayed
      print('All images displayed!');
    }
  }

  void moveToPreviousImage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      resetTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void navigateBackToChallengeScreen() {
    Navigator.pop(context, widget.dayNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${widget.dayNumber} Exercises'),
      ),
      body: isTimerActive
          ? Column(
              children: [
                Card(
                  child: Column(
                    children: [Text("Process:"), Text(exercises[currentIndex])],
                  ),
                ),
                SizedBox(height: 20),
                CircularCountDownTimer(
                  duration: timerSeconds,
                  controller: _controller,
                  width: 120,
                  height: 120,
                  ringColor: Color(0xffFDC830),
                  ringGradient: null,
                  fillColor: Color(0xffec9706),
                  fillGradient: null,
                  backgroundColor: Colors.transparent,
                  strokeWidth: 10.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {
                    // Do something when the timer starts
                  },
                  onComplete: () {
                    setState(() {
                      isTimerActive = false;
                    });
                    // Do something when the timer completes
                  },
                ),
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Container(
                    height: 150,
                    width: 150,
                    child: Image.asset("images/clock.png")),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: currentIndex > 0 &&
                          currentIndex != exercises.length - 1
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: moveToPreviousImage,
                                  child: Text('Previous',
                                      style: TextStyle(fontSize: 20)),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Color(0xff108319), // Background color
                                    onPrimary: Colors.white, // Text color
                                  ),
                                ),
                                SizedBox(width: 60),
                                ElevatedButton(
                                  onPressed: moveToNextImage,
                                  child: Text(
                                    'Next',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Color(0xff108319), // Background color
                                    onPrimary: Colors.white, // Text color
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: resetTimer,
                              child: Text(
                                'Restart',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff108319), // Background color
                                onPrimary: Colors.white, // Text color
                              ),
                            ),
                          ],
                        )
                      : currentIndex == 0
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: resetTimer,
                                      child: Text(
                                        'Restart',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(
                                            0xff108319), // Background color
                                        onPrimary: Colors.white, // Text color
                                      ),
                                    ),
                                    SizedBox(width: 60),
                                    ElevatedButton(
                                      onPressed: moveToNextImage,
                                      child: Text(
                                        'Next',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(
                                            0xff108319), // Background color
                                        onPrimary: Colors.white, // Text color
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: resetTimer,
                                      child: Text(
                                        'Restart',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(
                                            0xff108319), // Background color
                                        onPrimary: Colors.white, // Text color
                                      ),
                                    ),
                                    SizedBox(width: 60),
                                    ElevatedButton(
                                      onPressed: moveToPreviousImage,
                                      child: Text(
                                        'Previous',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(
                                            0xff108319), // Background color
                                        onPrimary: Colors.white, // Text color
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    navigateBackToChallengeScreen();
                                  },
                                  child: Text(
                                    'Done',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Color(0xffec9706), // Background color
                                    onPrimary: Colors.white, // Text color
                                  ),
                                ),
                              ],
                            ),
                ),
              ],
            ),
      floatingActionButton: isTimerActive
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  if (_isPause) {
                    _isPause = false;
                    _controller.resume();
                  } else {
                    _isPause = true;
                    _controller.pause();
                  }
                });
              },
              icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
              label: Text(_isPause ? 'Resume' : 'Pause'),
              backgroundColor: Color(0xff108319),
              foregroundColor: Colors.white,
            )
          : null,
    );
  }
}
