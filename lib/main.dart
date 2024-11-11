import 'package:flutter/material.dart';
import 'package:problems/backtracking/queens/queens_widgets.dart';
import 'package:problems/backtracking/queens/solve_queen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = '';
  QueenProblemSolver? _solver;

  void _solveQueen() {
    final count = int.tryParse(_counter);
    if (count == null) return;
    if (_counter == _solver?.size.toString() && _solver != null) {
      _solver!.solve();
      return;
    }
    setState(() {
      _solver = QueenProblemSolver(List.generate(
        count,
        (index) => List.generate(count, (j) => null),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Enter size of problem (integer)',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (value) => _counter = value,
          ),
          const SizedBox(height: 24),
          if (_solver != null)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: QueensWidgets(queen: _solver!),
              ),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _solveQueen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
