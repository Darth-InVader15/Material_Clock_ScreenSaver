import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimeScreensaver(),
    );
  }
}

class TimeScreensaver extends StatefulWidget {
  @override
  _TimeScreensaverState createState() => _TimeScreensaverState();
}

class _TimeScreensaverState extends State<TimeScreensaver> {
  String _timeString = "";
  double _gradientPosition = 0.0;
  bool _increasing = true;

  @override
  void initState() {
    super.initState();
    _timeString = _formatTime(DateTime.now());
    Timer.periodic(Duration(minutes: 1), (Timer t) => _updateTime());
    Timer.periodic(Duration(milliseconds: 50), (Timer t) => _updateGradient());
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatTime(now);
    setState(() {
      _timeString = formattedTime;
    });
  }

  void _updateGradient() {
    setState(() {
      if (_increasing) {
        _gradientPosition += 0.01;
        if (_gradientPosition >= 1.0) {
          _increasing = false;
        }
      } else {
        _gradientPosition -= 0.01;
        if (_gradientPosition < -0.3) {
          _increasing = true;
        }
      }
    });
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.blue[900]!],
            stops: [_gradientPosition, _gradientPosition + 0.5],
          ),
        ),
        child: Center(
          child: Text(
            _timeString,
            style: GoogleFonts.honk(
              color: Colors.white,
              fontSize: 400,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,

          ),

        ),
      ),
    );
  }
}