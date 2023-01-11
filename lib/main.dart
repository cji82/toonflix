import 'package:flutter/material.dart';

class Player {
  String? name;
  Player({required this.name});
}

void main() {
  //var nico = Player(name:"nico");
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Flutter!!'),
          centerTitle: true,
        ),
        body: Center(child: Text('Hello World!')),
      ),
    );
  }
}
