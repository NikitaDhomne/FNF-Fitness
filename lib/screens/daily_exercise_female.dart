import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:fnf_fitness/widgets/heading_home_title.dart';

class DailyExerciseFemaleDetail extends StatefulWidget {
  final String title;

  final String gifUrl;
  final String description;
  const DailyExerciseFemaleDetail(
      {super.key,
      required this.title,
      required this.gifUrl,
      required this.description});

  @override
  State<DailyExerciseFemaleDetail> createState() =>
      _DailyExerciseFemaleDetailState();
}

class _DailyExerciseFemaleDetailState extends State<DailyExerciseFemaleDetail> {
  int currentIndex = 0;
  bool isTimerActive = true;
  int timerSeconds = 60;
  bool _isPause = false;

  late Timer _timer;
  final CountDownController _controller = CountDownController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Daily Exercise Female"),
        ),
        body: Column(
          children: [
            Column(
              children: [
                HeadingTitle(title: widget.title),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Card(
                    elevation: 5, // Adjust the elevation as needed
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0), // Set border radius
                    ),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            15.0), // Same as Card's border radius
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffee9ca7),
                            Color(0xffffdde1),
                          ], // Set gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15.0), // Clip image to match Card's border radius
                        child: Image.network(
                          widget.gifUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      HeadingTitle(title: "Description :"),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.description,
                          softWrap: true,
                        ),
                      )
                    ],
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
                    Navigator.pop(context);
                    // Do something when the timer completes
                  },
                ),
              ],
            )
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
                label: Text(_isPause ? 'Resusme' : 'Pause'),
                backgroundColor: Color(0xff108319),
                foregroundColor: Colors.white,
              )
            : null);
  }
}
