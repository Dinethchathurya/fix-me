import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:flutter/material.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _UserScreenState();
}

class _UserScreenState extends State<PersonalDetails> {
  // Create text editing controllers to access the data typed in by the user.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  // The 'userId' variable is a nullable variable.
  String? userId;

  @override
  void initState() {
    super.initState();
    // Get the current user ID from fire-store database.
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 172, 231),
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "User",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                  height: 30,
                ),
                Text(
                  "Personal Details",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "NIC Number",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: nicController,
                  decoration: InputDecoration(
                    labelText: "Enter your NIC number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  // Validate the 'NIC Number' field to check if it has been left empty.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "NIC number is missing";
                    }
                    // Validate the 'NIC Number' field to check if the entered NIC number is valid or not.
                    RegExp nicRegExp = RegExp(r'^\d{9}[Vv0-9]$');
                    if (!nicRegExp.hasMatch(value)) {
                      return "Enter a valid NIC number";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Contact Number",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: contactController,
                  decoration: InputDecoration(
                    labelText: "Enter your contact number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  // Validate the 'Contact Number' field to check if it is empty.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Contact number is missing";
                    }
                    // Validate the 'Contact Number' field to check if the contact number consists of only numbers.
                    RegExp contactRegExp = RegExp(r'^[0-9]{10}$');
                    if (!contactRegExp.hasMatch(value)) {
                      return "Enter a valid contact number";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    // When the 'Continue' button is pressed, we update the fields in the database by
                    // adding the 'nicNumber' and the 'contactNumber' to the existing fields present within the relevant document, which is located in a collection called 'users'.
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .update({
                              'nicNumber': nicController.text,
                              'contactNumber': contactController.text,
                            });

                            // Navigate to MapScreen when the 'Continue' button is pressed.
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(),
                              ),
                            );
                          } catch (e) {
                            print('Error: $e');
                            // Handle error
                          }
                        }
                      },
                      child: Text(
                        "Continue",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
