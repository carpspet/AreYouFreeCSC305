// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

class GroupAvailability extends StatefulWidget {
  final double? width;
  final double? height;
  final String groupNameTab;

  const GroupAvailability({
    Key? key,
    this.width,
    this.height,
    required this.groupNameTab,
  }) : super(key: key);

  @override
  State<GroupAvailability> createState() => _GroupAvailabilityState();
}

class _GroupAvailabilityState extends State<GroupAvailability> {
  List<Map<String, dynamic>> availabilityList = [];

  @override
  void initState() {
    super.initState();
    getGroupAvailability();
  }

  Future<void> getGroupAvailability() async {
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('getGroupAvailability');
      final response = await callable.call({'groupName': widget.groupNameTab});
      final groupAvailability = response.data['groupAvailability'] as List;

      setState(() {
        availabilityList = List<Map<String, dynamic>>.from(groupAvailability);
      });
    } catch (e) {
      print("Error fetching group availability: $e");
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
    if (status.toLowerCase().startsWith('free after')) {
      return Colors.yellow;
    }

    switch (status) {
      case 'free all day':
        return Colors.green;
      case 'busy all day':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
