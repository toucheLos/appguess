import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';

void main() {
  runApp(Screen7());
}

class Screen7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complex State Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameBoard(),
    );
  }
}

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<List<int>> grid = List.generate(4, (_) => List.generate(4, (_) => 0));

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    _addRandomTile();
    _addRandomTile();
  }

  void _addRandomTile() {
    List<Offset> emptyCells = [];
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row][col] == 0) {
          emptyCells.add(Offset(row.toDouble(), col.toDouble()));
        }
      }
    }
    if (emptyCells.isNotEmpty) {
      Offset randomCell = emptyCells[emptyCells.length];
      grid[randomCell.dx.toInt()][randomCell.dy.toInt()] =
          (Random().nextInt(10) == 0) ? 4 : 2;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2048 Game Board'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 16,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 4;
                  int col = index % 4;
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _getColorForValue(grid[row][col]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        grid[row][col] == 0 ? '' : '${grid[row][col]}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _initializeGrid();
                });
              },
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForValue(int value) {
    switch (value) {
      case 2:
        return Colors.lightBlueAccent;
      case 4:
        return Colors.blue;
      case 8:
        return Colors.deepPurpleAccent;
      case 16:
        return Colors.purple;
      case 32:
        return Colors.orange;
      case 64:
        return Colors.deepOrangeAccent;
      case 128:
        return Colors.yellow;
      case 256:
        return Colors.green;
      case 512:
        return Colors.teal;
      case 1024:
        return Colors.red;
      case 2048:
        return Colors.pinkAccent;
      default:
        return const Color.fromARGB(255, 99, 99, 99);
    }
  }
}
