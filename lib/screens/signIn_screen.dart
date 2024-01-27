import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnf_fitness/providers/user_setup.dart';
import 'package:fnf_fitness/screens/dashboard.dart';
import 'package:fnf_fitness/screens/signUp_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/heading_title_widget.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  var preference;

  bool loader = false;
  bool google_loader = false;

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void login() {
    setState(() {
      loader = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passController.text.toString())
        .then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
      setState(() {
        loader = false;
      });
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
                        'Invalid Credentials',
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
        loader = false;
      });
    });
  }

  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final _user = userCredential.user;
    print("User Name: ${_user!.displayName}");
    print("User Email ${_user.email}");
    final email = _user.email;
    final userName = _user.displayName;
    userSetUp(userName!, email!);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("images/fnf_logo.png"),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    HeadingTitleWidget(title: "Welcome Back"),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Enter your Email',
                      ),
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
                      controller: passController,
                      keyboardType: TextInputType.text,
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
                      obscureText: hidePassword,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Forgot Password?',
                              style: TextStyle(color: Color(0xffec9706))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          login();
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
                        child: loader
                            ? CircularProgressIndicator()
                            : Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
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
                      height: screenHeight * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        signInWithGoogle();
                      },
                      child: google_loader
                          ? SizedBox(
                              height: screenHeight * 0.02,
                              width: screenWidth * 0.05,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
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
                                      child: Image.asset(
                                          "images/google_logo.png")),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  Text(
                                    'Sign in with Google',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
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
                        Text('Don\'t have an accout please '),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Color(0xffec9706),
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
