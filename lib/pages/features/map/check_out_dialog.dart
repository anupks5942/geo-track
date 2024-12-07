import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutDialog extends StatefulWidget {
  const CheckOutDialog({super.key});

  @override
  _CheckOutDialogState createState() => _CheckOutDialogState();
}

class _CheckOutDialogState extends State<CheckOutDialog> {
  final List<String> reasons = [
    "Finished Work",
    "Personal Errand",
    "Meeting Outside",
    "Other",
  ];
  String? selectedReason;
  final TextEditingController customReasonController = TextEditingController();
  String? errorText; // Error for TextField
  String? selectionError; // Error if no reason selected

  @override
  void dispose() {
    customReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Checkout Reason",
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...reasons.map((reason) {
            return RadioListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
              visualDensity: const VisualDensity(vertical: -4),
              value: reason,
              groupValue: selectedReason,
              title: Text(
                reason,
              ),
              onChanged: (value) {
                setState(() {
                  selectedReason = value;
                  selectionError = null; // Clear selection error
                  errorText = null; // Clear TextField error
                  if (selectedReason != "Other") {
                    customReasonController
                        .clear(); // Clear custom reason if not "Other"
                  }
                });
              },
            );
          }),
          if (selectionError != null) // Show error if no reason is selected
            Text(
              selectionError!,
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontSize: 10.sp,
                // fontSize: width * 0.025,
              ),
            ),
          if (selectedReason == "Other") // Show only if "Other" is selected
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey),
                //     borderRadius: BorderRadius.circular(8.r),
                //   ),
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 12.w),
                //     child:
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 3,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: customReasonController,
                  decoration: const InputDecoration(
                    hintText: "Enter your reason",
                    border: InputBorder.none,
                  ),
                ),
                //   ),
                // ),
                if (errorText !=
                    null) // Display error text outside the TextField
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      errorText!,
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 10.sp,
                        // fontSize: width * 0.025,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
      actions: [
        TextButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          onPressed: () {
            Navigator.pop(context); // Cancel button
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          onPressed: () {
            setState(() {
              // Check if no option is selected
              if (selectedReason == null) {
                selectionError = "Please select a reason.";
              } else if (selectedReason == "Other" &&
                  customReasonController.text.isEmpty) {
                // Check if "Other" is selected but TextField is empty
                errorText = "Please enter a reason.";
              } else {
                // If all validations pass
                String finalReason = selectedReason == "Other"
                    ? customReasonController.text
                    : selectedReason!;
                log("Checked out with reason: $finalReason");
                Navigator.of(context).pop(finalReason);
              }
            });
          },
          child: Text(
            "Submit",
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: const Color.fromARGB(255, 27, 109, 244),
            ), // Responsive font size
          ),
        ),
      ],
    );
  }
}

void showCheckOutDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false, // Prevents tapping outside to close
    context: context,
    builder: (BuildContext context) {
      return const PopScope(
        // canPop: false, // Prevents dismissal on back button
        child: CheckOutDialog(),
      );
    },
  );
}
