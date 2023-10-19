import 'package:flutter/material.dart';
import 'dart:async';

class CircularButton extends StatefulWidget {
  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  bool _pressed = false;
  int _countdown = 3;

  void _startCountdown() {
    setState(() {
      _pressed = true;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          _pressed = false;
          _countdown = 3;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            _startCountdown();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: _pressed
                      ? Border.all(color: Colors.white, width: 10)
                      : null,
                ),
                child: _pressed
                    ? Center(
                        child: Text(
                          _countdown.toString(),
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                      )
                    : Icon(Icons.alarm),
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: _pressed
                      ? Border.all(color: Colors.white, width: 10)
                      : null,
                ),
                child: _pressed
                    ? Center(
                        child: Text(
                          _countdown.toString(),
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                      )
                    : Icon(Icons.alarm),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
