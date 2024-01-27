import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fnf_fitness/widgets/daily_exercise_male.dart';

class Belly extends StatefulWidget {
  const Belly({super.key});

  @override
  State<Belly> createState() => _BellyState();
}

class _BellyState extends State<Belly> {
  late Future<QuerySnapshot<Map<String, dynamic>>> data;

  @override
  void initState() {
    super.initState();
    // Initialize the future when the widget is created
    data = FirebaseFirestore.instance.collection('WeightGain').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Belly"),
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
                final des1 = document['des1'];
                final des2 = document['des2'];
                final des3 = document['des3'];

                final gifUrl = document['gifUrl'];
                final id = document.id;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DailyExerciseMaleDetail(
                                title: title,
                                gifUrl: gifUrl,
                                des1: des1,
                                des2: des2,
                                des3: des3)));
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
