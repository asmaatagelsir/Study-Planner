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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // LOGIC: the goals, a list of maps with three keys
  List<Map<String, dynamic>> goals = [
    {'subject': 'Python', 'hours': 4, 'done': false},
    {'subject': 'Mathematics', 'hours': 3, 'done': false},
    {'subject': 'Database Management Systems', 'hours': 2, 'done': false},
    {
      'subject': 'Software Testing and Quality Assurance',
      'hours': 5,
      'done': false,
    },
    {'subject': 'Computer Networks', 'hours': 3, 'done': false},
  ];
  // LOGIC: three real subjects the floating button can add, one after another
  List<Map<String, dynamic>> sampleGoals = [
    {'subject': 'Data Structures', 'hours': 5},
    {'subject': 'Operating Systems', 'hours': 4},
    {'subject': 'Web Development', 'hours': 2},
  ];
  int nextSample = 0;

  // LOGIC: which card the mouse is on (null means none)
  int? hoverdIndex;

  // LOGIC: add the next sample goal (a new Map each time)
  void addGoal() {
    setState(() {
      Map<String, dynamic> sample =
          sampleGoals[nextSample % sampleGoals.length];
      goals.add({
        'subject': sample['subject'],
        'hours': sample['hours'],
        'done': false,
      });
      nextSample++;
    });
  }

  // LOGIC: flip done between true and false
  void toggleGoal(int index) {
    setState(() {
      goals[index]['done'] = !goals[index]['done'];
    });
  }

  // LOGIC: remove one goal
  void deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
      hoverdIndex = null;
    });
  }

  // LOGIC: choose an icon from the subject name
  IconData iconFor(String subject) {
    String name = subject.toLowerCase();
    if (name.contains('math')) return Icons.calculate;
    if (name.contains('python') || name.contains('web')) return Icons.code;
    if (name.contains('network')) return Icons.computer;
    if (name.contains('test')) return Icons.science;
    return Icons.book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STATIC: AppBar
      appBar: AppBar(
        title: const Text(
          'My Study Planner',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'georgia'),
        ),
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
