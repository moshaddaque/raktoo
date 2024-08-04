import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:raktoo/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBZHnnQP1iUmiOqD-9kb8TCglxV1kU2FEI",
        authDomain: "raktoo-ed25c.firebaseapp.com",
        projectId: "raktoo-ed25c",
        storageBucket: "raktoo-ed25c.appspot.com",
        messagingSenderId: "279069685668",
        appId: "1:279069685668:web:f440a9447afffb090ef331",
        measurementId: "G-WH9TR1V401",
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
