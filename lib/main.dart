import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_track/services/functions/auth_provider.dart';
import 'package:geo_track/services/functions/auth_state_builder.dart';
import 'package:geo_track/services/providers/auth_data_provider.dart';
import 'package:geo_track/services/providers/map_type_provider.dart';
import 'package:geo_track/services/settings/notification_service.dart';
import 'package:geo_track/services/providers/geofence_provider.dart';
import 'package:provider/provider.dart';
import 'package:geo_track/services/providers/permission_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geo_track/services/settings/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final NotificationService notificationService = NotificationService();
  // await notificationService.initNotification();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GeofenceProvider()),
        ChangeNotifierProvider(create: (context) => PermissionProvider()),
        ChangeNotifierProvider(create: (context) => MapTypeProvider()),
        ChangeNotifierProvider(create: (context) => AuthDataProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeNotificationService();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    themeNotifier.updateThemeMode();
  }

  Future<void> _initializeNotificationService() async {
    final NotificationService notificationService = NotificationService();
    await notificationService.initNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    final brightness = MediaQuery.of(context).platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
    ));

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'GeoTrack',
        theme: themeNotifier.customLightTheme,
        darkTheme: themeNotifier.customDarkTheme,
        themeMode: themeNotifier.themeMode,
        debugShowCheckedModeBanner: false,
        home: const AuthStateBuilder(),
      ),
    );
  }
}
