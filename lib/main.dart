import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'presentation/screens/to_do_screen.dart';
import 'presentation/bloc/task_bloc.dart';
import 'data/repository/task_repository.dart';
import 'domain/events/to_do_event.dart'; // ← ДОБАВЬ ЭТО!

void main() async {
  await Hive.initFlutter();
  final taskBox = await Hive.openBox<Map>('tasks');
  runApp(MyApp(taskBox: taskBox));
}

class MyApp extends StatelessWidget {
  final Box<Map> taskBox;

  const MyApp({required this.taskBox, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) =>
            TaskBloc(TaskRepository(taskBox))..add(LoadTasks()),
        child: Scaffold(
          appBar: AppBar(title: const Text('TO-DO APP')),
          body: const ToDoScreen(),
        ),
      ),
    );
  }
}
