import 'package:car_app/src/configs/widget/button_page.dart';
import 'package:car_app/src/pages/routers.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final PageController _pageController1 = PageController(initialPage: 0);
  final PageController _pageController2 = PageController(initialPage: 0);
  Timer? _timer1;
  Timer? _timer2;
  int _currentPage1 = 0;
  int _currentPage2 = 0;

  final appIcon = 'assets/app-icon0.png';
  final colorAppIcon = Colors.black;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer1!.cancel();
    _timer2!.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentPage1 < 6) {
        _currentPage1++;
      } else {
        _currentPage1 = 0;
      }
      _pageController1.animateToPage(
        _currentPage1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });

    _timer2 = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage2 < 6) {
        _currentPage2++;
      } else {
        _currentPage2 = 0;
      }
      _pageController2.animateToPage(
        _currentPage2,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void navigateSignUp(BuildContext ctx) {
    Navigator.pushNamed(ctx, Routers.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  appIcon,
                  color: colorAppIcon,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AutoTECH',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'write your own journey',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 200,
              width: 300,
              child: ListView.builder(
                controller: _pageController1,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Image.asset(
                    'assets/car${index + 1}.png',
                    width: 300,
                    height: 250,
                  );
                },
              ),
            ),
            SizedBox(
              height: 150,
              width: 300,
              child: ListView.builder(
                controller: _pageController2,
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Image.asset(
                    'assets/car${index + 1}.png',
                    width: 300,
                    height: 250,
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'The best car in your\nhand with AutoTECH',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ButtonPage(
                    onTap: () {
                      navigateSignUp(context);
                    },
                    text: 'Continue',
                    color: Colors.black,
                    colortext: Colors.white,
                    width: double.maxFinite,
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
