import 'package:geo_track/auth/login_or_signup.dart';
import 'package:geo_track/services/functions/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_track/services/providers/permission_provider.dart';
import 'package:provider/provider.dart';

class AuthStateBuilder extends StatelessWidget {
  const AuthStateBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.read<PermissionProvider>().loadInitialScreen(context);
        }
        return const LogInOrSignUp();
      },
    );
  }
}
