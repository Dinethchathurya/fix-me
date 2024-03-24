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
  final TextEditingController contactControl