import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qlmoney/data/login_main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDPJX3zFi737iip5Si5JGimi2cAuGBAZIs",
      appId: "1:1064752535102:android:ef2d195b96926b577ce36f",
      messagingSenderId: "XXX",
      projectId: "quanlychitieu-ccdbf",
      databaseURL: 'https://quanlychitieu-ccdbf-default-rtdb.asia-southeast1.firebasedatabase.app/',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginMainPage(),
    );
  }
}
