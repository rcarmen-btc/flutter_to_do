import 'package:flutter/material.dart';
import 'package:flutter_to_do/presentation/screens/to_do_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('TO-DO APP'),
          actions: [
            IconButton(
              onPressed: () {
                print('Pika');
              },
              icon: Icon(Icons.light_mode),
            ),
          ],
        ),
        body: ToDoScreen(),
      ),
    );
  }
}
