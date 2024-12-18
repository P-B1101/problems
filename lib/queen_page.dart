import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'backtracking/queens/queens.dart';
import 'widget/action_button.dart';

class QueenPage extends StatefulWidget {
  static const route = 'queens';
  const QueenPage({super.key});

  @override
  State<QueenPage> createState() => _QueenPageState();
}

class _QueenPageState extends State<QueenPage> {
  String _counter = '';
  bool _createMode = true;
  QueenProblemSolver? _solver;

  void _onTap() {
    final count = int.tryParse(_counter);
    if (count == null) return;
    if (_counter == _solver?.size.toString() && _solver != null) {
      setState(() {
        _createMode = true;
      });
      _solver!.solve();
      return;
    }
    setState(() {
      _createMode = false;
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
        title: const Text('N-Queens'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter size of table (integer)',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: 200,
              child: CupertinoTextField(
                onChanged: (value) => _counter = value,
                textAlign: TextAlign.center,
                readOnly: !_createMode,
              ),
            ),
            const SizedBox(height: 24),
            ActionButton.mode(
              onTap: _onTap,
              isCreateMode: _createMode,
            ),
            const SizedBox(height: 12),
            if (_solver != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: QueensWidget(queen: _solver!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
