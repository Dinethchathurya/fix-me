import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MechanicScreen extends StatefulWidget {
  const MechanicScreen({Key? key}) : super(key: key);

  @override
  State<MechanicScreen> createState() => _MechanicScreenState();
}

class _MechanicScreenState extends State<MechanicScreen> {
  // Create text editing controllers to access the data typed in by the mechanic.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  // Create a nullable variable called 'mechanicId' that stores the id retrieved from the database.
  String? mechanicId;

  @override
  void initState() {
    super.initState();
    // Get the current mechanic ID from the fire-store database.
    mechanicId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 172, 231),
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Mechanic",
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
                  // Validate the 'NIC Number' field to check whether it is not empty.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "NIC number is missing";
                    }
                    // Validate the 'NIC Number' field to check whether it consists of numbers from 1-9 followed by a 'V' or 'v'.
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
                    // Validate the 'Contact Number' field to ensure that the entered contact number consists only of digits.
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
                    child: ElevatedButton(
                      // When the 'Continue' button is pressed, the document for the existing 'users' collection is updated with the 'nicNumber' and 'contactNumber' of the mechanic.
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(mechanicId)
                                .update({
                              'nicNumber': nicController.text,
                              'contactNumber': contactController.text,
                            });

                            // Navigate to MapScreen upon pressing the 'Continue' button.
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
