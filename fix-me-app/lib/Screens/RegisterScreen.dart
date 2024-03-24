import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_me_app/Screens/LoginScreen.dart';
import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:fix_me_app/Screens/MechanicScreen.dart';
import 'package:fix_me_app/Screens/UserScreen.dart';
import 'package:flutter/material.dart';
import 'package:fix_me_app/Screens/AuthPage.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController();
  bool _isObscuredText = false;

  // Create a variable called '_image' of type 'File'. This variable can potentially be nullable.
  File? _image;

  // The '_showUploadOptions' is an asynchronous function that shows a bottom sheet.
  // It pauses the execution of the function when the 'await' keyword is encountered and resumes it's execution once a result is returned after the operation has been successfully completed.
  Future<void> _showUploadOptions() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // The 'Wrap' widget is wrapped around a 'Container' widget that consists of two 'children' widgets in the bottom sheet.
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Open Camera"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Browse Files On Device"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // The '_pickImageFromCamera' is another asynchronous function that creates an instance of the 'ImagePicker()' that is provided from the 'image_picker' flutter package.
  // The function is haulted until the user opens the camera. Once the camera is opened the function resumes it's execution.
  // If any image is selected it will be set as the image path.
  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        // The '_image' variable is of type 'File'.
        _image = File(pickedFile.path);
      });
    }
  }

  // Create a variable called 'selectedRole' that may or may not be null.
  String? selectedRole;

  // Create a list that consists of the roles.
  final List<String> roles = ['Select a role', 'User', 'Mechanic'];

  // The 'signUserUp' method is called when the 'Sign Up' button is pressed.
  Future<void> signUserUp() async {
    if (_formKey.currentState!.validate()) {
      // If the selected role is 'Select a role' , an error message is displayed.
      if (selectedRole == 'Select a role') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Invalid Role"),
              content: Text("Please select a role."),
              actions: [
                TextButton(
                  onPressed: () {
                    // Closes the alert dialog upon clicking on the "OK" text button.
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        return;
      }

      // Get current timestamp.
      Timestamp timestamp = Timestamp.now();

      try {
        // Creates a user with email and password.
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Set user data in Firestore by creating a collection named 'users' along with
        // the relavant documents.
        // The 'set' method, sets the data in the database.
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': emailController.text,
          'role': selectedRole, // Set selected role from dropdown
          'registrationTimestamp': timestamp,
          // Store the 'URL' of the image in the database, if it is available.
          'imageURL': _image != null ? _image!.path : null,
        });

        // Determine which screen to navigate to based on the selected role.
        if (selectedRole == 'User') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserScreen()),
          );
        } else if (selectedRole == 'Mechanic') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MechanicScreen()),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Handle FirebaseAuth exceptions
        if (e.code == 'email-already-in-use') {
          wrongEmailMessage("Email already in use");
        } else if (e.code == 'invalid-email') {
          wrongEmailMessage("Invalid email");
        }
      }
    }
  }

  void wrongEmailMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Email already in use"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
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
                        obscureText: _isObscuredText,
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
                      "Role",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      hint: Text("Select a role"),
                      items: roles.map((String role) {
                        return DropdownMenuItem<String>(
                            value: role, child: Text(role));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == 'Select a role') {
                          return "Invalid role";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: signUserUp,
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
