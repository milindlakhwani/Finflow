import 'package:finflow_iot/core/router.dart';
import 'package:finflow_iot/features/notifications/firebase_api.dart';
import 'package:finflow_iot/features/screens/splash_screen.dart';
import 'package:finflow_iot/firebase_options.dart';
import 'package:finflow_iot/theme/pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseApi().initNotifications();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finflow',
      debugShowCheckedModeBanner: false,
      theme: Pallete.appTheme,
      home: const SplashScreen(),
      routes: allRoutes,
    );
  }
}
