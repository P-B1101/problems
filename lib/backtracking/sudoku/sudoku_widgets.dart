import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widget/action_button.dart';
import 'sudoku_cell.dart';
import 'sudoku_problem_solver.dart';

class SudokuWidget extends StatelessWidget {
  final SudokuProblemSolver sudoku;
  const SudokuWidget({
    super.key,
    required this.sudoku,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sudoku,
      builder: (context, value, child) => _BoarbWidget(value),
    );
  }
}

class SudokuInputWidget extends StatefulWidget {
  final Function(SudokuProblemSolver? solver) onSolverChange;
  const SudokuInputWidget({
    super.key,
    required this.onSolverChange,
  });

  @override
  State<SudokuInputWidget> createState() => _SudokuInputWidgetState();
}

class _SudokuInputWidgetState extends State<SudokuInputWidget> {
  List<List<int?>> _grid = List.generate(9, (index) => List.filled(9, null));

  bool _createMode = true;
  bool _clearValue = false;

  void _onStart() async {
    if (_createMode) {
      setState(() {
        _createMode = false;
      });
      final solver = SudokuProblemSolver(_grid);
      widget.onSolverChange(solver);
      await Future.delayed(Duration.zero);
      solver.solve();
      return;
    }
    setState(() {
      _createMode = true;
    });
    widget.onSolverChange(null);
  }

  void _clear() async {
    setState(() {
      _grid = List.generate(9, (index) => List.filled(9, null));
      _clearValue = !_clearValue;
    });
    await Future.delayed(Duration.zero);
    setState(() {
      _clearValue = !_clearValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_clearValue)
          _BaseBoardBuilder(
            (size, index, innerIndex) => CupertinoTextField(
              onChanged: (value) => _grid[index][innerIndex] = int.tryParse(value),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\b[1-9]\b')),
              ],
              textAlign: TextAlign.center,
              readOnly: !_createMode,
              maxLength: 1,
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        const SizedBox(height: 12),
        ActionButton.text(
          onTap: _onStart,
          text: _createMode ? 'Start' : 'Stop',
        ),
        if (_createMode)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ActionButton.text(
              onTap: _clear,
              text: 'Clear',
            ),
          ),
      ],
    );
  }
}

class _BaseBoardBuilder extends StatelessWidget {
  final Widget Function(int size, int index, int innerIndex) builder;
  const _BaseBoardBuilder(this.builder);

  @override
  Widget build(BuildContext context) {
    const size = 9;
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black87)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cellSize = (constraints.maxWidth - size + 1) / size;
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              child: ListView.separated(
                itemCount: size,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => Container(
                  width: 1,
                  color: Colors.black87,
                  height: cellSize,
                ),
                itemBuilder: (context, index) => SizedBox(
                  width: cellSize,
                  child: ListView.separated(
                    itemCount: size,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => Container(
                      width: cellSize,
                      color: Colors.black87,
                      height: 1,
                    ),
                    itemBuilder: (context, innerIndex) => SizedBox(
                      height: cellSize,
                      child: builder(size, index, innerIndex),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BoarbWidget extends StatelessWidget {
  final List<SudokuCell> items;
  const _BoarbWidget(this.items);

  @override
  Widget build(BuildContext context) {
    return _BaseBoardBuilder(
      (size, index, innerIndex) => _CellWidget(
        cell: items[(size * index) + innerIndex],
      ),
    );
  }
}

class _CellWidget extends StatelessWidget {
  final SudokuCell cell;
  const _CellWidget({
    required this.cell,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: cell.isValueEmpty
          ? cell.isCacheEmpty
              ? Colors.white
              : Colors.yellow.withOpacity(.8)
          : Colors.green,
      child: Text(
        cell.value?.toString() ?? cell.cacheValue?.toString() ?? '',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
