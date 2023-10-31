// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:car_app/src/pages/routers.dart';
import 'package:car_app/src/pages/utils/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  Timer _startDelay() => _timer = Timer(const Duration(seconds: 2), _init);

  Future<void> goToPreview(BuildContext context) =>
      Navigator.pushNamed(context, Routers.previewPage);

  Future<void> goToHome(BuildContext context) =>
      Navigator.pushNamed(context, Routers.bottomNavigatorScreen);

  Future<void> _init() async {
    // _goToSignIn(context);
    print(FirebaseAuth.instance.currentUser?.uid);
    final token = await AppPref.getToken();
    if (token == null || token.isEmpty) {
      await goToPreview(context);
    } else {
      await goToHome(context);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/welcom-img.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              const Text(
                'HI, WELCOM TO',
                style: TextStyle(
                  fontSize: 23,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,  
                children: [
                  Image.asset('assets/app-icon0.png', color: Colors.black),
                  const Text(
                    'AutoTECH',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
