
import 'dart:convert';

import 'package:fix_me_app/Services/GetMechanicLocation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Components/UsersFirstMapScreen.dart';

import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF39ACE7),
        onPressed: () async {
          await Provider.of<GetMechanicLocation>(context, listen: false)
              .getMechanicLocationMethod();

          final int indexOfLowestDistance =
              Provider.of<GetMechanicLocation>(context, listen: false)
                  .indexOfLowestDistance;

          var data = {
            'to':
                '${Provider.of<GetMechanicLocation>(context, listen: false).token[indexOfLowestDistance]}',
            'priority': 'high',
            'notification': {
              'title':
                  'Your client in ${Provider.of<GetMechanicLocation>(context, listen: false).originAddresses[0]}',
              'body':
                  'Travel time :${Provider.of<GetMechanicLocation>(context, listen: false).duration[indexOfLowestDistance]}',
            },
            'data': {'type': 'msj', 'id': 'assdf173'}
          };

          try {
            var response = await http.post(
              Uri.parse('https://fcm.googleapis.com/fcm/send'),
              body: jsonEncode(data),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization':
                    'key=AAAAvzTn5yk:APA91bFoIoL1_ybpM7XVXdIZSnmV2Z8HDO2tGR757I-vvtMXDLui6wMBsMy0QbTH2peTVZvB0Lybz7DJXJX-3hqh-Q_316yKIpX6seHldMus4ClijEEKbw_dXbfLlHlWaPJKGypv911A',
              },
            );

            if (response.statusCode == 200) {
              print('Notification sent successfully');
            } else {
              print(
                  'Failed to send notification. Status code: ${response.statusCode}');
            }
          } catch (error) {
            print('Error sending notification: $error');
          }
        },
        label: const Text('Confirm Request '),
      ),
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
