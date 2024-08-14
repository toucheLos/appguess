import 'package:flutter/material.dart';
import 'screens/screen_1.dart';
import 'screens/screen_2.dart';
import 'screens/screen_3.dart';
import 'screens/screen_4.dart';
import 'screens/screen_5.dart';
import 'screens/screen_6.dart';
import 'screens/screen_7.dart';
import 'screens/screen_8.dart';
import 'screens/screen_9.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Playground",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen1()),
                  );
                },
                child: Text("Application 1"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen2()),
                  );
                },
                child: Text("Application 2"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen3()),
                  );
                },
                child: Text("Application 3"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen4()),
                  );
                },
                child: Text("Application 4"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen5()),
                  );
                },
                child: Text("Application 5"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen6()),
                  );
                },
                child: Text("Application 6"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen7()),
                  );
                },
                child: Text("Application 7"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen8()),
                  );
                },
                child: Text("Application 8"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Screen9()),
                  );
                },
                child: Text("Application 9"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
