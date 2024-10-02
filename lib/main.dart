//main

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jewellery/Login_Screens/user_check.dart';
import 'package:jewellery/Login_Screens/welcome_screen.dart';
import 'package:jewellery/Screens/home_screen.dart';
import 'package:jewellery/Screens/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBaUYdu2peLV-PwOpCgRT8mUY89yO4Gm1c",
      appId: "1:59654702050:android:8635d6e850a283fa37afbb",
      messagingSenderId: "59654702050",
      projectId: "balaji-jewellers-d4735",
    ),
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userPhoneNumber = prefs.getString('userPhoneNumber');

  final AuthService authService = AuthService();
  bool userLoggedIn = false;
  if (userPhoneNumber != null) {
    userLoggedIn = await authService.doesUserPhoneNumberExist(userPhoneNumber);

    if (!userLoggedIn) {
      // Clear userPhoneNumber from SharedPreferences
      await prefs.remove('userPhoneNumber');
    }
  }

  runApp(MyApp(userLoggedIn: userLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool userLoggedIn;

  const MyApp({super.key, required this.userLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: userLoggedIn ? const TabsScreen() : const WelcomeScreen(),
      // home: TabsScreen(),
      title: "Balaji Jewellers",
    );
  }
}
