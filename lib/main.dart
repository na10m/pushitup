import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/launch_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'counterhome.dart';

late List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new PushItUp());
}

//void main() => runApp(const PushItUp());

class PushItUp extends StatelessWidget {
  const PushItUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        ),
      initialRoute: LaunchScreen.id,
      routes: {
        LaunchScreen.id: (context) => const LaunchScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
      },

    );
  }
}

