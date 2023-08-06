// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_management/Screens/Register.dart';
import 'package:food_management/Screens/adminapp.dart';
import 'package:food_management/constants.dart';
import 'Collector.dart';
// import 'package:panorama/panorama.dart';
import 'Provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool _isValid = false;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // final SensorControl sensorControl = SensorControl.AbsoluteOrientation;
    return Stack(
      children:[
        // Panorama(
        //   animSpeed: 0.5,
        //   sensorControl: SensorControl.Orientation,
        //   child: Image.asset('lib/images/123.jpeg', fit: BoxFit.cover),
        // ),
        Scaffold(
          backgroundColor: Colors.yellow,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[

                  Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Email',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Email cannot be empty";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                emailController.text = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              autocorrect: false,
                              controller: passwordController,
                              obscureText: _isObscure3,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(_isObscure3
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure3 = !_isObscure3;
                                      });
                                    }),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Password',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 15.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("please enter valid password min. 6 character");
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                passwordController.text = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  visible = true;
                                });
                                signIn(
                                    emailController.text, passwordController.text);
                              },
                              color: Colors.white,
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _isValid ? Visibility(
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                visible: visible,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                )) : Text(''),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      MaterialButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        elevation: 5.0,
                        height: 50,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          );
                        },
                        color: Colors.blue[900],
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if(documentSnapshot.get('rool') == "admin"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Admin(),
            ),
          );
        }else if (documentSnapshot.get('rool') == "Provider") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Provider(
                email: emailController.text,
                address: documentSnapshot.get('address'),
                mobile: documentSnapshot.get('Mobile'),
                shopname: documentSnapshot.get('shopname'),
                username: documentSnapshot.get('username'),
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Collector(email: emailController.text,),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        setState(() {
          _isValid = true;
        });
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            passwordController.clear();
            emailController.clear();
            _isValid = false;
          });
          showSnackBar('The user is not registered', context);
        } else if (e.code == 'wrong-password') {
          setState(() {
            passwordController.clear();
            _isValid = false;
          });
          showSnackBar('Wrong password provided for that user.', context);
        }
      }
    }
  }
}
