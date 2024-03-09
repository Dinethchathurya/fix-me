import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_me_app/Screens/LoginScreen.dart';
import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:flutter/material.dart';
import 'package:fix_me_app/Screens/AuthPage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final contactnumberController = TextEditingController();
  bool _isObscuredText = false;

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapScreen()),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'email-already-in-use') {
        wrongEmailMessage("Email already in use");
      } else if (e.code == 'invalid-email') {
        wrongEmailMessage("Invalid email");
      } else if (e.code == 'wrong-contactnumber') {
        wrongContactNumber("Invalid contact number");
      }
    }
  }

  void wrongEmailMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  void wrongContactNumber(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Enter your email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is missing";
                          }
                          String emailRegExp =
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          RegExp regexp = RegExp(emailRegExp);
                          if (!regexp.hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscuredText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscuredText = !_isObscuredText;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is missing";
                          }
                          if (value.length < 8) {
                            return "Password should be a minimum of eight characters";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Contact Number",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: contactnumberController,
                        decoration: InputDecoration(
                          labelText: "Enter your contact number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Contact number is missing";
                          }
                          if (value.length > 10) {
                            return "Contact number should be ten digits";
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "Contact number should be numeric";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add the functionality to the 'Sign Up' button.
                            if (_formKey.currentState!.validate()) {
                              signUserUp();
                            }
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF39ACE7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account ?",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
