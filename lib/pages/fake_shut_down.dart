import 'package:flutter/material.dart';

class FakeShutdownScreen extends StatefulWidget {
  @override
  _FakeShutdownScreenState createState() => _FakeShutdownScreenState();
}

class _FakeShutdownScreenState extends State<FakeShutdownScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool _isShuttingDown = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _startShutdown() {
    setState(() {
      _isShuttingDown = true;
    });
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: _isShuttingDown
              ? RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller!),
                  child: Icon(Icons.power_settings_new, size: 100),
                )
              : ElevatedButton(
                  onPressed: _startShutdown,
                  child: Text('Shutdown'),
                ),
        ),
      ),
    );
  }
}
