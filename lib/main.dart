import 'package:flutter/material.dart';

const Color pantoneOrange = Color(0xFFF57E1E);
const Color neonPink = Color(0xFFF52380);
const LinearGradient pinkGradient = LinearGradient(
  colors: [neonPink, neonPink],
);
const LinearGradient orangGradient = LinearGradient(
  colors: [pantoneOrange, pantoneOrange],
);
const LinearGradient mixGradien = LinearGradient(
  colors: [pantoneOrange, neonPink],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
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

  // LOGIC: sum of all hours (fold starts at 0 and adds each goal's hours)
  int get totalHours {
    return goals.fold<int>(0, (sum, goal) => sum + (goal['hours'] as int));
  }

  // LOGIC: goals where done is true, then count them
  int get completeGoals {
    return goals.where((goal) => goal['done'] == true).length;
  }

  // LOGIC: goals not finished yet
  int get remaininGoals {
    return goals.length - completeGoals;
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
            // STATIC: Summary section (three circles from the same widget)
            // CONNECTION: the numbers come from the LOGIC getters
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: StatCircle(
                      value: '$totalHours',
                      label: 'Total hours',
                      gradient: orangGradient,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: StatCircle(
                      value: '$completeGoals',
                      label: 'Completed',
                      gradient: mixGradien,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: StatCircle(
                      value: '$remaininGoals',
                      label:' Remaining goals',
                      gradient: pinkGradient,
                    ),
                  ),
                ),
                
              ],
            ),
            // STATIC: Heading
            const Text(
              'My Study Goals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: pantoneOrange,
                fontFamily: 'georgia',
              ),
            ),
            const SizedBox(height: 12),

            // CONNECTION: ListView.builder makes one card for each goal Map
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> goal = goals[index];
                  bool done = goal['done'];
                  bool hovered = hoverdIndex == index;

                  // STATIC: goal card (hover shows the checkbox and delete button)
                  return MouseRegion(
                    onEnter: (_) => setState(() => hoverdIndex = index),
                    onExit: (_) => setState(() {
                      if(hoverdIndex== index) hoverdIndex = null;
                    }) ,
                    child: Card(
                      color: hovered ? Colors.orange.shade50: done? Colors.grey.shade200: Colors.white,
                      child: ListTile(
                        onTap: () => toggleGoal(index),
                        leading: Checkbox(value: done, 
                        activeColor: neonPink,
                        onChanged: (_) => toggleGoal(index)),

                        title: Text(goal['subject'], style: TextStyle(decoration: done? TextDecoration.lineThrough: null),),
                        subtitle: Text('${goal['hours']} hours'),
                        trailing: IconButton(onPressed: () => deleteGoal(index), icon: const Icon(
                          Icons.delete_outline, color: neonPink,
                        ),),
                      ),
                    ),
                  );

                },
              ),
            ),
          ],
        ),
      ),
      // STATIC: FloatingActionButton
      floatingActionButton: FloatingActionButton(
        // CONNECTION: pressing the button calls the LOGIC function addGoal
        onPressed: addGoal,
        backgroundColor: pantoneOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StatCircle extends StatelessWidget {
  final String value;
  final String label;
  final Gradient gradient;

  const StatCircle({
    super.key,
    required this.value,
    required this.label,
    required this.gradient,
  });
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: gradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
