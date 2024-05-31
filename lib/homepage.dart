import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/authservice.dart';
import 'package:social_media_app/locator.dart';
import 'package:social_media_app/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Welcome to the Home Page"),
            ElevatedButton(
              onPressed: () {
                _signOut();
              },
            child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
  void _signOut() {
    locator<AuthService>().logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}