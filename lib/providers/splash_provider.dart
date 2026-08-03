import 'dart:async';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  double _progress = 0.0;
  bool _isComplete = false;
  Timer? _timer;

  double get progress => _progress;
  bool get isComplete => _isComplete;

  void startLoading({VoidCallback? onComplete}) {
    _progress = 0.0;
    _isComplete = false;
    notifyListeners();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      _progress += 0.012;
      if (_progress >= 1.0) {
        _progress = 1.0;
        _isComplete = true;
        timer.cancel();
        notifyListeners();
        onComplete?.call();
      } else {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
