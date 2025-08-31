import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_track/widgets/features/profile/info_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.email!.split('@')[0])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log(snapshot.error.toString());
          }

          final userData = snapshot.data?.data();

          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.blueGrey
                          : Colors.blueGrey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 80.w,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InfoTile(
                  leadingIcon: Icons.person_outline,
                  label: 'Name',
                  value: userData?['name'] ?? 'null',
                ),
                // InfoTile(
                //   leadingIcon: Icons.badge_outlined,
                //   label: 'User ID',
                //   value: userData?['email']?.split('@')[0] ?? 'null',
                // ),
                // InfoTile(
                //   leadingIcon: Icons.work_outline,
                //   label: 'Role',
                //   value: userData?['role'] ?? 'null',
                // ),
                InfoTile(
                  leadingIcon: Icons.groups,
                  label: 'Department',
                  value: userData?['dept'] ?? 'null',
                ),
                const InfoTile(
                  leadingIcon: Icons.apartment,
                  label: 'Office Location',
                  value: 'GAIL Office, Bhopal',
                ),
                InfoTile(
                  leadingIcon: Icons.date_range,
                  label: 'DOB',
                  value: userData?['dob'] ?? 'null',
                ),
                InfoTile(
                  leadingIcon: Icons.phone_outlined,
                  label: 'Phone',
                  value: userData?['phone'] ?? 'null',
                ),
                InfoTile(
                  leadingIcon: Icons.email_outlined,
                  label: 'Email',
                  value: userData?['email'] ?? 'null',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
