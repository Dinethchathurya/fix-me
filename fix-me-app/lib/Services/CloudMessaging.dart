import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestMessage extends StatelessWidget {
  const TestMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('SENT NOTIFY'),
          onPressed: () async {
            var data = {
              'to':
                  'dBVzik_2S9SlQoY5wv468n:APA91bFMO9TXbdFt3YaBpZfWw9B95BQrSAh6PoVXG8is8xloSA78XqKt52bsacMh3sd0Zho5IORZSqAEaD2a2bxUlKhJA-splxIZwbKSbvSOBbyKHT5Ti_OTCVOxJ_poTg-LJoWvLuAn',
              'priority': 'high',
              'notification': {
                'title': 'get your client',
                'body': 'hello dineth',
              },
              'data': {'type': 'msj', 'id': 'assdf123'}
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
        ),
      ),
    );
  }
}
