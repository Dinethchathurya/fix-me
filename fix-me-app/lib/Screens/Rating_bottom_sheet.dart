import 'package:flutter/material.dart';

class RatingBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('assets/profile_photo.jpg'),
          ),
          SizedBox(height: 20.0),
          Text(
            'Same person',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Yes action
                  Navigator.pop(context);
                  _showRatingBottomSheet(context);
                },
                child: Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle No action
                  Navigator.pop(context);
                  _showRatingBottomSheet(context);
                },
                child: Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRatingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return RatingBottomSheet();
      },
    );
  }
}
