import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app_lab2/firebase_options.dart';
import 'package:jokes_app_lab2/services/notification_service.dart';
import 'screens/home_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationsService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '213160',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      navigatorKey: navigatorKey,
    );
  }
}