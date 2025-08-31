import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:geo_track/services/providers/geofence_provider.dart';

Future<void> showCheckOutDialog(BuildContext context) async {
  final TextEditingController reasonController = TextEditingController();
  
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Check Out'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Are you sure you want to check out?'),
          SizedBox(height: 16.h),
          TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              labelText: 'Reason for leaving',
              hintText: 'Enter your reason...',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final reason = reasonController.text.trim();
            if (reason.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a reason for checking out'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
            context.read<GeofenceProvider>().manualCheckOut(reason);
            Navigator.pop(context);
          },
          child: const Text('Check Out'),
        ),
      ],
    ),
  );
}
