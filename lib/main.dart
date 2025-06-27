import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:main/controllers/auth_controller.dart';

import 'package:main/firebase_option.dart';
import 'package:main/services/repositories/auth_repository/auth_repository.dart';
import 'package:main/services/repositories/auth_repository/auth_services.dart';
import 'package:main/views/auth/auth_screen.dart';
import 'package:main/views/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

final FirebaseMessaging msgS = FirebaseMessaging.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env.dev');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(
    AuthController(
      authRepository: AuthRepository(authService: AuthService()),
      authService: AuthService(),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX Login',
      home: FirebaseAuth.instance.currentUser == null
          ? const AuthScreen()
          : const MyHomePage(title: 'Home'),
    );
  }
}
