import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:error404/views/livedetection.dart';
import 'package:error404/views/onbording.dart';
import 'package:provider/provider.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DetectedObjectsProvider()),
      ],
      child: const MaterialApp(
        title: 'Object Detection App',
        debugShowCheckedModeBanner: false,
        // home: ObjectDetectionScreen(),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Onbording(),
          ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 0,
          ),
          Container(
            height: 600,
            margin: EdgeInsets.fromLTRB(20, 180, 20, 0),
            decoration: const BoxDecoration(
                color: Color.fromARGB(0, 0, 47, 73), shape: BoxShape.circle, 
                ),
            width: double.infinity,
            child: Image.asset('./assets/logo3.png',height: 700,width: 700),
          ),
          const SizedBox(
            height: 0,
          ),
          const Center(
              child: Text(
            '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 247, 127, 80)
              
            ),
          )),
        ],
      ),
    );
  }
}
