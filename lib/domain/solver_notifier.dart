import 'package:flutter/foundation.dart';

abstract class SolverNotifier<T> extends ChangeNotifier implements ValueListenable<T> {
  Future<void> notify(Function() func) async {
    func();
    notifyListeners();
    await Future.delayed(duration);
  }

  Duration get duration => Duration.zero;

  void solve();

  bool isCalculating = false;
}
