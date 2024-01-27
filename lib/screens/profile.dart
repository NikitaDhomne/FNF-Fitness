import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(_user.uid).get();

      setState(() {
        _nameController.text = _user.displayName!;
        _emailController.text = _user.email!;
        _selectedDate = (userDoc['birthday'] as Timestamp).toDate();
        _selectedGender = userDoc['gender'];
      });
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage, // Implement image picking logic
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage(
                    'images/profile_image.png'), // Replace with user's profile image
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Birthday: ${_formatDate(_selectedDate)}',
                  style: TextStyle(fontSize: 16.0),
                ),
                IconButton(
                  onPressed: _selectDate,
                  icon: Icon(Icons.calendar_today),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedGender,
              onChanged: (String? value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
              items: ['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save user profile changes
                _saveProfileChanges();
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    // Implement image picking logic
  }

  Future<void> _selectDate() async {
    final DateTime pickedDate = (await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _saveProfileChanges() {
    // Implement logic to save user profile changes
    String name = _nameController.text;
    String email = _emailController.text;

    // Use 'name', 'email', '_selectedDate', '_selectedGender' for saving changes
    // ...
  }
}




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.amber,
//                 radius: 30,
//                 child: Text(
//                   user!.displayName![0],
//                   style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'Username : ',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     user!.displayName!,
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'Email : ',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     user!.email!,
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
