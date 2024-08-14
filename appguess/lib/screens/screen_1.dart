import 'package:flutter/material.dart';
import 'dart:math';

import '../main.dart';

void main() {
  runApp(Screen1());
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Runaway Ball',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RunawayBallScreen(),
    );
  }
}

class RunawayBallScreen extends StatefulWidget {
  @override
  _RunawayBallScreenState createState() => _RunawayBallScreenState();
}

class _RunawayBallScreenState extends State<RunawayBallScreen> {
  Offset _ballPosition = Offset(100, 100);
  double _ballSize = 50.0;

  void _moveBall(PointerEvent details) {
    setState(() {
      final random = Random();
      double newX = random.nextDouble() * (MediaQuery.of(context).size.width - _ballSize);
      double newY = random.nextDouble() * (MediaQuery.of(context).size.height - _ballSize);
      _ballPosition = Offset(newX, newY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Runaway Ball Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: _ballPosition.dx,
            top: _ballPosition.dy,
            child: MouseRegion(
              onHover: _moveBall,
              child: Container(
                width: _ballSize,
                height: _ballSize,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
