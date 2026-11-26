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
        title: const Text('My Study Planner', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'georgia')),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [pantoneOrange, neonPink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STATIC: Heading
            Text(
              'My Study Goals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: pantoneOrange,
                fontFamily: 'georgia',
              ),
            ),

            const SizedBox(height: 12),

            // STATIC: Goals list
            Card(
              child: ListTile(
                leading: Icon(Icons.book, color: neonPink),
                title: const Text('Python'),
                subtitle: const Text('4 hours'),
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
                title: const Text('Database Management Systems'),
                subtitle: const Text('2 hours'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.science, color: neonPink),
                title: const Text('Software Testing and Quality Assurance'),
                subtitle: const Text('5 hours'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.computer, color: neonPink),
                title: const Text('Computer Networks'),
                subtitle: const Text('3 hours'),
              ),
            ),
          ],
        ),
      ),
      // STATIC: FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: pantoneOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
