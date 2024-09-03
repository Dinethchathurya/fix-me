import 'package:flutter/material.dart';

class RatingBottomSheet extends StatefulWidget {
  @override
  _RatingBottomSheetState createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  int _selectedRating = 3; // Default to Neutral
  bool _showRating = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _showRating ? _buildRatingView() : _buildInitialView(),
      ),
    );
  }

  List<Widget> _buildInitialView() {
    return [
      CircleAvatar(
        radius: 50.0,
        backgroundImage: AssetImage('assets/profile_photo.jpg'),
      ),
      SizedBox(height: 20.0),
      Text(
        'You met the same person as in the above picture.',
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
              setState(() {
                _showRating = true;
              });
            },
            child: Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No'),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildRatingView() {
    return [
      Text(
        'Rate the garage mechanic\'s service quality',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildStar(1, 'Bad'),
          buildStar(2, ''),
          buildStar(3, 'Neutral'),
          buildStar(4, ''),
          buildStar(5, 'Good'),
        ],
      ),
      SizedBox(height: 20.0),
      ElevatedButton(
        onPressed: () {
          String ratingText;
          if (_selectedRating == 1) {
            ratingText = 'Bad';
          } else if (_selectedRating == 3) {
            ratingText = 'Neutral';
          } else {
            ratingText = 'Good';
          }
          print('Selected Rating: $_selectedRating ($ratingText)');
          Navigator.pop(context, _selectedRating);
        },
        child: Text('Submit'),
      ),
    ];
  }

  Widget buildStar(int index, String text) {
    IconData iconData = index <= _selectedRating ? Icons.star : Icons.star_border;
    return Column(
      children: [
        IconButton(
          icon: Icon(iconData),
          onPressed: () {
            setState(() {
              _selectedRating = index;
            });
          },
        ),
        Text(text),
      ],
    );
  }
}
