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

      body: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // STATIC: Heading
      Text('My Study Goals',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: pantoneOrange,
          ),
        ),

      const SizedBox(height: 12),

      // STATIC: Goals list
      Card(
        child: ListTile(
          leading: Icon(Icons.book, color: neonPink),
          title: const Text('Python'),
          subtitle: const Text('2 hours'),
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.calculate, color: neonPink),
          title: const Text('Mathematics'),
          subtitle: const Text('3 hours'),
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.code, color: neonPink),
          title: const Text('Flutter'),
          subtitle: const Text('2 hours'),
        ),
      ),
    ],
  ),
),
    );
  }
}
