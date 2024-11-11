import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'queen_cell.dart';
import 'queen_problem_solver.dart';

class QueensWidget extends StatelessWidget {
  final QueenProblemSolver queen;
  const QueensWidget({
    super.key,
    required this.queen,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder(
        valueListenable: queen,
        builder: (context, value, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BoarbWidget(value.$1),
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
                    child: _BoarbWidget(value.$2[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BoarbWidget extends StatelessWidget {
  final List<QueenCell> items;
  const _BoarbWidget(this.items);

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
  final QueenCell cell;
  final double size;
  const _CellWidget({
    required this.cell,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cell.isSelected
          ? Colors.green
          : cell.cacheSelected
              ? Colors.yellow.withOpacity(.8)
              : Colors.white,
    );
  }
}
