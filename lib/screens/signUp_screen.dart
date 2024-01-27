import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fnf_fitness/providers/user_setup.dart';
import 'package:fnf_fitness/screens/dashboard.dart';
import 'package:fnf_fitness/screens/signIn_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/heading_title_widget.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();

  bool loading = false;

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    confirmpassword.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    // If the form is valid, display a Snackbar.
    _auth
        .createUserWithEmailAndPassword(
            email: email.text.toString(), password: password.text.toString())
        .then((value) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 250,
                width: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'images/dialog_success.png',
                            fit: BoxFit.cover,
                          )),
                      Text(
                        "Account Created Successfully",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF1FB141), // background color
                          foregroundColor: Colors.white, // text color
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      )
                    ]),
              ),
            );
          });

      setState(() {
        loading = false;
      });
      userSetUp(username.text, email.text);
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 250,
                width: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'images/warning.png',
                            fit: BoxFit.cover,
                          )),
                      Text(
                        e.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF1FB141), // background color
                          foregroundColor: Colors.white, // text color
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      )
                    ]),
              ),
            );
          });
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("images/fnf_logo.png"),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  HeadingTitleWidget(title: 'Sign Up For FNF Fitness'),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: username,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Username',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '*Username is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.alternate_email),
                      labelText: 'Email',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Email is required.';
                      }
                      if (!value.contains('@')) {
                        return '* Must contain @.';
                      }
                      if (!value.endsWith('.com') &&
                          !value.endsWith('.in') &&
                          !value.endsWith('.co') &&
                          !value.endsWith('.gov') &&
                          !value.endsWith('.edu')) {
                        return '* Enter valid email id';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Password is required';
                      }
                      if (value.length < 6) {
                        return '* Password should have atleast 6 characters long';
                      }
                      if (value.length > 15) {
                        return '* Password should not be greater than 15 characters';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.text,
                    controller: password,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: hidePassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                      labelText: 'Password',
                    ),
                    obscureText: hidePassword,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Password is required';
                      }
                      if (value.length < 6) {
                        return '* Password should have atleast 6 characters long';
                      }
                      if (value.length > 15) {
                        return '* Password should not be greater than 15 characters';
                      }
                      print(password.text);
                      print(confirmpassword.text);
                      if (password.text != confirmpassword.text) {
                        return '* Password doesn\'t match';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.text,
                    controller: confirmpassword,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: hideConfirmPassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            hideConfirmPassword = !hideConfirmPassword;
                          });
                        },
                      ),
                      labelText: 'Confirm Password',
                    ),
                    obscureText: hideConfirmPassword,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_form.currentState!.validate()) {
                        signUp();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffec9706),
                      ),
                      height: screenHeight * 0.06,
                      width: screenWidth * 1,
                      alignment: Alignment.center,
                      child: loading
                          ? CircularProgressIndicator()
                          : Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Divider()),
                      Text(
                        '  OR  ',
                        style: GoogleFonts.publicSans(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: Divider())
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xffDFE5EA),
                        ),
                      ),
                      height: screenHeight * 0.06,
                      width: screenWidth * 1,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Image.asset("images/google_logo.png")),
                          SizedBox(
                            width: screenWidth * 0.03,
                          ),
                          Text(
                            'Sign up with Google',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an accout please '),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Color(0xffec9706)),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
