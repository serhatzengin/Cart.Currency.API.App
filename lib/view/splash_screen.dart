import 'dart:async';

import 'package:flutter/material.dart';

import 'store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const StorePage(
                    title: "Sigma Digital Chart App Serhat Zengin"))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 300.00,
                height: 300.00,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/logo/sigma_telecom.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
