// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

class FriendListAvailability extends StatefulWidget {
  final double? width;
  final double? height;

  const FriendListAvailability({Key? key, this.width, this.height})
      : super(key: key);

  @override
  State<FriendListAvailability> createState() => _FriendListAvailabilityState();
}

class _FriendListAvailabilityState extends State<FriendListAvailability> {
  List<Map<String, dynamic>> availabilityList = [];

  @override
  void initState() {
    super.initState();
    getFriendListAvailability();
  }

  Future<void> getFriendListAvailability() async {
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('getFriendListAvailability');
      final response = await callable.call();
      final friendAvailability =
          response.data['friendListAvailability'] as List;

      setState(() {
        availabilityList = List<Map<String, dynamic>>.from(friendAvailability);
      });

      print(
          "Fetched friend availability data: $friendAvailability"); // Debug statement
    } catch (e) {
      print("Error fetching availability: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width, // Set width from the parameter
      height: widget.height, // Set height from the parameter
      child: ListView.builder(
        itemCount: availabilityList.length,
        itemBuilder: (context, index) {
          final friend = availabilityList[index];
          final displayName = friend['displayName'];
          final availabilityStatus = friend['status'];
          final color = _getAvailabilityColor(availabilityStatus);

          // Debugging: Print out the status for each friend
          print("Friend: $displayName, Status: $availabilityStatus");

          return Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$displayName is $availabilityStatus',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getAvailabilityColor(String status) {
    // Check if the status includes 'free after' and return yellow if it does
    if (status.toLowerCase().startsWith('free after')) {
      return Colors.yellow; // Ensure it's yellow for "free after"
    }

    // Only check the other statuses if it's not "free after"
    switch (status) {
      case 'free all day':
        return Colors.green;
      case 'busy all day':
        return Colors.red;
      default:
        return Colors.grey; // Default grey for any unrecognized status
    }
  }
}
