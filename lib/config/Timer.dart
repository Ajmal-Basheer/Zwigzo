import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer;
  late int _seconds;

  @override
  void initState() {
    super.initState();
    _seconds = 420; // 7 minutes
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
        print('Timer is done!');
      }
    });
  }

  void resetTimer() {
    setState(() {
      _seconds = 420; // Reset to 7 minutes
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Text(
          'Deliver within ${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')} Minutes',
          style: TextStyle(fontSize: 20),
        ),
    );
  }
}
