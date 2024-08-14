import 'package:flutter/material.dart';
import '../main.dart';

void main() {
  runApp(Screen8());
}

class Screen8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation and Gesture Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureAnimationScreen(),
    );
  }
}

class GestureAnimationScreen extends StatefulWidget {
  @override
  _GestureAnimationScreenState createState() => _GestureAnimationScreenState();
}

class _GestureAnimationScreenState extends State<GestureAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _startOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _moveBox(Offset direction) {
    setState(() {
      _startOffset = _animation.value;
      _animation = Tween<Offset>(
        begin: _startOffset,
        end: _startOffset + direction,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe to Move Box'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _moveBox(Offset(1, 0)); // Move right
                } else {
                  _moveBox(Offset(-1, 0)); // Move left
                }
              },
              onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy > 0) {
                  _moveBox(Offset(0, 1)); // Move down
                } else {
                  _moveBox(Offset(0, -1)); // Move up
                }
              },
              child: SlideTransition(
                position: _animation,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Swipe Me',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  _moveBox(Offset(-1, 0)); // Move left
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  _moveBox(Offset(0, -1)); // Move up
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  _moveBox(Offset(0, 1)); // Move down
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  _moveBox(Offset(1, 0)); // Move right
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
