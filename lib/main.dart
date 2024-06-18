import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qlmoney/screen/screen_started.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDPJX3zFi737iip5Si5JGimi2cAuGBAZIs",
      appId: "1:1064752535102:android:ef2d195b96926b577ce36f",
      messagingSenderId: "XXX",
      projectId: "quanlychitieu-ccdbf",
      databaseURL:
          'https://quanlychitieu-ccdbf-default-rtdb.asia-southeast1.firebasedatabase.app/',
      storageBucket: 'gs://quanlychitieu-ccdbf.appspot.com',
    ),
  );

  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'Remind_1',
            channelName: 'Remind_Notification',
            channelDescription: "Ban co 1 nhac nho!")
      ],
      debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Management',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: SplashScreen(
        onTap: () {},
      ),
    );
  }
}
