import 'package:flutter/material.dart';

import 'backtracking/sudoku/sudoku.dart';

class SudokuPage extends StatefulWidget {
  static const route = 'sudoku';
  const SudokuPage({super.key});

  @override
  State<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  SudokuProblemSolver? _solver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sudoku'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter values 1 - 9 in table (integer) or leave it empty',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SudokuInputWidget(
                  onSolverChange: (solver) => setState(() {
                    _solver = solver;
                  }),
                ),
              ),
              if (_solver != null)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SudokuWidget(sudoku: _solver!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
