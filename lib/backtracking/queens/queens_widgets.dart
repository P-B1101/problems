import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:problems/backtracking/queens/colored_queen_problem_solver.dart';

import 'colored_queen_cell.dart';
import 'queen_cell.dart';
import 'queen_problem_solver.dart';

class QueensWidget extends StatefulWidget {
  final BaseQueenProblemSolver queen;
  const QueensWidget({
    super.key,
    required this.queen,
  });

  @override
  State<QueensWidget> createState() => _QueensWidgetState();
}

class _QueensWidgetState extends State<QueensWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder(
        valueListenable: widget.queen,
        builder: (context, value, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BoardWidget(value.$1, widget.queen is ColoredQueenProblemSolver && !value.$3 ? _onClick : null),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 8,
                spacing: 8,
                alignment: WrapAlignment.start,
                children: List.generate(
                  value.$2.length,
                  (index) => SizedBox(
                    width: 100,
                    height: 100,
                    child: _BoardWidget(value.$2[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClick(BaseQueenCell cell) {
    widget.queen.updateCell(cell);
  }
}

class _BoardWidget extends StatelessWidget {
  final List<BaseQueenCell> items;
  final Function(BaseQueenCell cell)? onClick;
  const _BoardWidget(this.items, [this.onClick]);

  @override
  Widget build(BuildContext context) {
    final size = math.sqrt(items.length).floor();
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
                      child: _CellWidget(
                        cell: items[(size * index) + innerIndex],
                        size: cellSize,
                        onClick: onClick,
                      ),
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

class _CellWidget extends StatelessWidget {
  final BaseQueenCell cell;
  final Function(BaseQueenCell cell)? onClick;
  final double size;
  const _CellWidget({
    required this.cell,
    required this.size,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    if (!_isColored) {
      return Container(
        color: cell.isSelected
            ? Colors.green.withOpacity(.5)
            : cell.cacheSelected
                ? Colors.amber.withOpacity(.5)
                : Colors.white.withOpacity(.5),
      );
    }
    return Container(
      color: (cell as ColoredQueenCell).color.color,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick == null ? null : () => onClick!(cell),
          child: cell.isSelected || cell.cacheSelected
              ? Icon(
                  Icons.person_2_rounded,
                  color: Colors.white.withOpacity(cell.cacheSelected ? .75 : 1),
                  size: size * .75,
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  bool get _isColored => cell is ColoredQueenCell;
}
