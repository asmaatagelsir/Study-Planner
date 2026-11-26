import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ));

// STATIC: colors
const orange = Color(0xFFF57E1E);
const pink = Color(0xFFF52380);
const bg = Color(0xFFFFFBF7);

// STATIC: screen is a StatefulWidget so it can change
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // LOGIC: goals list and sample goals
  var goals = [
    {'subject': 'Mathematics', 'hours': 5, 'done': false},
    {'subject': 'Mobile App Development', 'hours': 8, 'done': false},
    {'subject': 'Databases', 'hours': 4, 'done': false},
    {'subject': 'Networking', 'hours': 3, 'done': false},
    {'subject': 'Software Testing', 'hours': 6, 'done': false},
  ];

  var samples = [
    {'subject': 'Physics', 'hours': 3},
    {'subject': 'English', 'hours': 2},
    {'subject': 'Operating Systems', 'hours': 5},
    {'subject': 'Algorithms', 'hours': 4},
    {'subject': 'Project Management', 'hours': 6},
  ];

  int next = 0;

  // LOGIC: add a sample goal
  void addGoal() {
    setState(() {
      goals.add({...samples[next % samples.length], 'done': false});
      next++;
    });
  }

  // LOGIC: toggle done state
  void toggle(int i) {
    setState(() {
      goals[i]['done'] = !(goals[i]['done'] as bool);
    });
  }

  // LOGIC: remove a goal
  void delete(int i) {
    setState(() => goals.removeAt(i));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      // STATIC: gradient app bar
      appBar: AppBar(
        title: const Text('My Study Planner'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [orange, pink],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // STATIC: heading
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'My Study Goals',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: pink,
              ),
            ),
          ),

          // CONNECTION 1: goals list builds the cards
          Expanded(
            child: ListView.builder(
              itemCount: goals.length,
              itemBuilder: (context, i) {
                final bool done = goals[i]['done'] as bool;
                // STATIC: goal card
                return Card(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  color: done ? Colors.grey.shade200 : Colors.white,
                  child: ListTile(
                    onTap: () => toggle(i),
                    leading: Checkbox(
                      value: done,
                      activeColor: i.isEven ? orange : pink,
                      onChanged: (_) => toggle(i),
                    ),
                    title: Text(
                      goals[i]['subject'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('${goals[i]['hours']} hours'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: pink),
                      onPressed: () => delete(i),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // CONNECTION 2: button calls addGoal
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addGoal,
        backgroundColor: pink,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add goal'),
      ),
    );
  }
}