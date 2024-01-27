import 'package:flutter/material.dart';
import 'package:fnf_fitness/screens/fitness_challenge_exercisedetail_screen.dart';
import 'package:fnf_fitness/screens/weightgain_list.dart';
import 'package:fnf_fitness/screens/weightloss_list.dart';

class WeightGainLossScreen extends StatefulWidget {
  const WeightGainLossScreen({super.key});

  @override
  State<WeightGainLossScreen> createState() => _WeightGainLossScreenState();
}

class _WeightGainLossScreenState extends State<WeightGainLossScreen> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Gain/Loss'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeightGain()),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'images/weight_gain.png'), // Replace with your own avatar image
              ),
            ),
            SizedBox(height: 20),
            Text("Weight Gain",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 80),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeightLoss()),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'images/weight_loss.png'), // Replace with your own avatar image
              ),
            ),
            SizedBox(height: 20),
            Text("Weight Loss",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// import 'package:fnf_fitness/screens/fitness_challenge_exercisedetail_screen.dart';

// class FitnessChallengeScreen extends StatefulWidget {
//   @override
//   _FitnessChallengeScreenState createState() => _FitnessChallengeScreenState();
// }

// class ExerciseDay {
//   int dayNumber;
//   bool isCompleted;

//   ExerciseDay({required this.dayNumber, this.isCompleted = false});
// }

// class _FitnessChallengeScreenState extends State<FitnessChallengeScreen> {
//   List<ExerciseDay> days = List.generate(30, (index) => ExerciseDay(dayNumber: index + 1));

//   Widget buildDayContainer(int dayNumber) {
//     return GestureDetector(
//       onTap: () {
//         // Handle onTap action for the day
//         print('Day ${dayNumber} tapped!');
//         // You can add additional actions when a day is tapped.
//       },
//       child: Container(
//         margin: EdgeInsets.all(8),
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: day.isCompleted ? Colors.green : Colors.blue,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Day ${day.dayNumber}',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             // You can add more widgets here, such as icons, checkmarks, etc.
//             // to represent the completion status of the day.
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
     
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fitness Challenge'),
//       ),
// body:  GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 5, // Number of columns in the grid
//           ),
//           itemCount: days.length,
//           itemBuilder: (context, index) {
//             return buildDayContainer(days[index] as Day);
//           },
//         ));
        

//       // body: ListView.builder(
//       //   itemCount: days.length,
//       //   itemBuilder: (context, index) {
//       //     return ListTile(
//       //       title: Text('Day ${index + 1}'),
//       //       subtitle:
//       //           Text(days[index].isCompleted ? 'Completed' : 'Not Completed'),
//       //       onTap: () async {
//       //         bool result =
//       //             await navigateToExerciseDetailScreen(context, index + 1);
//       //         if (result) {
//       //           setState(() {
//       //             days[index].isCompleted = true;
//       //           });
//       //         }
//       //       },
//       //     );
//       //   },
//       // ),
    
//   }

//   Future<bool> navigateToExerciseDetailScreen(
//       BuildContext context, int dayNumber) async {
//     bool result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FitnessChallengeExerciseDetailScreen(
//           dayNumber: dayNumber,
//           isExerciseCompleted: days[dayNumber - 1].isCompleted,
//         ),
//       ),
//     );

//     return result;
//   }
// }

