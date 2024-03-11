import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestFirebase extends StatelessWidget {
  const TestFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            // List<Map<String, dynamic>> tempList = [];
            try {
              await db.collection("location").get().then(
                (querySnapshot) {
                  print("Successfully completed");
                  for (var docSnapshot in querySnapshot.docs) {
                    print('helo ${docSnapshot.id} => ${docSnapshot.data()}');
                  }
                },
                onError: (e) => print("Error completing: $e"),
              );
            } catch (e) {
              print(e);
            }
          },
          child: Text('get data'),
        ),
      ),
    );
  }
}
