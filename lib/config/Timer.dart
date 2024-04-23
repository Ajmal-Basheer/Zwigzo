import 'dart:async';

import 'package:flutter/cupertino.dart';

class CountdownTimer {
  late Timer _timer;
  late int _secondsRemaining;
  final int _totalSeconds;
  final void Function(int) _onTick;
  final void Function() _onFinished;

  CountdownTimer(this._totalSeconds, this._onTick, this._onFinished)
      : _secondsRemaining = _totalSeconds;

  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _secondsRemaining--;
      _onTick(_secondsRemaining);
      if (_secondsRemaining <= 0) {
        _timer.cancel();
        _onFinished();
      }
    });
  }

  void reset() {
    _secondsRemaining = _totalSeconds;
  }

  void cancel() {
    _timer.cancel();
  }
}


class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late CountdownTimer _countdownTimer;
  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = 420; // 7 minutes
    _countdownTimer = CountdownTimer(
      _secondsRemaining,
      _onTick,
      _onFinished,
    );
    _countdownTimer.start();
  }

  void _onTick(int secondsRemaining) {
    setState(() {
      _secondsRemaining = secondsRemaining;
    });
  }

  void _onFinished() {
    print('Timer is done!');
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
            'Deliver within ${_secondsRemaining ~/ 60}:${(_secondsRemaining % 60).toString().padLeft(2, '0')} Minutes',
            style: TextStyle(fontSize: 12),
      ),
    );
  }
}
