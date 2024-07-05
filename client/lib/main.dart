import 'package:client/app/auth/login.dart';
import 'package:client/app/auth/signup.dart';
import 'package:client/app/auth/success.dart';
import 'package:client/app/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: sharedPref.getString("id") == null ? 'login' : 'home',
      routes: {
        'login': (context) => const Login(),
        'signup': (context) => const SignUp(),
        'home': (context) => const Home(),
        'success': (context) => const Success(),
      },
    );
  }
}
