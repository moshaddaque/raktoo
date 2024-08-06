import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:raktoo/controller/auth_controller.dart';
import 'package:raktoo/controller/home_controller.dart';
import 'package:raktoo/utils/app_style.dart';
import 'package:raktoo/utils/colors.dart';
import 'package:raktoo/utils/config.dart';
import 'package:raktoo/views/home/home.dart';
import 'package:raktoo/views/no_internet/no_internet.dart';
import 'package:raktoo/views/welcome/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.put(HomeController());
  final authController = Get.put(AuthController());
  final user = FirebaseAuth.instance.currentUser;

  final Connectivity _connectivity = Connectivity();

  StreamSubscription? subscription;

  @override
  void initState() {
    // _connectivity.onConnectivityChanged.listen((e) => _updateConnectionStatus);
    authController.getProfileData();

    subscription =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          // The internet is now connected
          // Get.snackbar("Success", "Internet Connected");
          if (user == null) {
            Get.offAll(() => const Welcome());
          } else {
            Get.offAll(() => const Home());
          }
          break;
        case InternetStatus.disconnected:
          // The internet is now disconnected
          // Get.snackbar("Bad Network", "Not Connected");
          Get.offAll(() => const NoInternet());
          break;
      }
    });

    Timer(
      const Duration(seconds: 3),
      () {},
    );
    subscription = Connectivity().onConnectivityChanged.listen(
          (event) => _checkInternetConnection,
        );
    _connectivity.onConnectivityChanged.listen(
      (event) => _updateConnectionStatus,
    );

    // _checkInternetConnection();
    super.initState();
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("Success", "Connect with mobile");
      if (user == null) {
        Get.offAll(() => const Welcome());
      } else {
        Get.offAll(() => const Home());
      }
    } else {
      Get.snackbar("Bad Network", "Not Connected");
      Get.offAll(() => const NoInternet());
    }
  }

  Future _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      Get.snackbar("Success", "Connect with mobile");
      if (user == null) {
        Get.offAll(() => const Welcome());
      } else {
        Get.offAll(() => const Home());
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      Get.snackbar("Success", "Connect with wifi");
      if (user == null) {
        Get.offAll(() => const Welcome());
      } else {
        Get.offAll(() => const Home());
      }
    } else {
      Get.snackbar("Success", "Not Connected");
      Get.to(() => const NoInternet());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primaryColor,
        child: const Center(
          child: Text(AppConfig.appName, style: AppStyle.h1Text),
        ),
      ),
    );
  }
}
