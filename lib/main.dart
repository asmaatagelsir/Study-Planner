import 'package:flutter/material.dart';

const Color pantoneOrange = Color(0xFFF57E1E);
const Color neonPink = Color(0xFFF52380);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Study Planner',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: pantoneOrange,
          secondary: neonPink,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STATIC: AppBar
      appBar: AppBar(
        title: const Text('My Study Planner'),
        backgroundColor: pantoneOrange,
        foregroundColor: Colors.white,
      ),

      body: const Center(child: Text('Welcome to My Study Planner!')),
    );
  }
}
