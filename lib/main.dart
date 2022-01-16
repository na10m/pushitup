import 'package:flutter/material.dart';
import 'package:pushitup/screens/home_screen.dart';
import 'screens/launch_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'package:pushitup/screens/challenge_screen.dart';
import 'package:pushitup/screens/camera_screen.dart';
import 'package:pushitup/screens/leaderboard_screen.dart';
import 'package:pushitup/screens/analytics_screen.dart';
import 'package:pushitup/screens/goals_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PushItUp());
}

class PushItUp extends StatelessWidget {
  PushItUp({Key? key}) : super(key: key);
  final Future<FirebaseApp> defaultApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: defaultApp,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('SomethingWentWrong');
        }

        // Once complete, show your application
        if (snapshot.hasData) {
          return MaterialApp(
            title: 'Push It Up',
            theme: ThemeData.dark().copyWith(
              primaryColor: const Color(0xFF0A0E21),
              scaffoldBackgroundColor: const Color(0xFF0A0E21),
            ),
            initialRoute: LaunchScreen.id,
            routes: {
              LaunchScreen.id: (context) => const LaunchScreen(),
              LoginScreen.id: (context) => const LoginScreen(),
              RegistrationScreen.id: (context) => const RegistrationScreen(),
              HomeScreen.id: (context) => const HomeScreen(),
              ChallengeScreen.id: (context) => const ChallengeScreen(),
              CameraScreen.id: (context) => const CameraScreen(),
              LeaderboardScreen.id: (context) => const LeaderboardScreen(),
              AnalyticsScreen.id: (context) => const AnalyticsScreen(),
              GoalsScreen.id: (context) => const GoalsScreen(),
            },

          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          child: Image.asset('images/logo.png'),
        );
      },
    );
  }
}

