import 'dart:convert';

import 'package:fix_me_app/Services/GetMechanicLocation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Components/UsersFirstMapScreen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
        title: Text('User Home Screen'),
        backgroundColor: const Color(0xFF39ACE7),
      ),
      body: Center(
        child: UsersFirstMapScreen(),
      ),
    );
  }
}
