import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_state.dart';
import '../../domain/events/to_do_event.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TaskError) {
          return Center(child: Text('Ошибка: ${state.message}'));
        }

        if (state is TaskLoaded) {
          return Column(
            children: [
              // Список задач
              Expanded(
                child: ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) {
                          context.read<TaskBloc>().add(ToggleTask(index));
                        },
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<TaskBloc>().add(DeleteTask(index));
                        },
                      ),
                    );
                  },
                ),
              ),
              // Поле ввода
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Новая задача...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FloatingActionButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          context.read<TaskBloc>().add(
                            AddTask(_controller.text),
                          );
                          _controller.clear();
                        }
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const Center(child: Text('Нет данных'));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
