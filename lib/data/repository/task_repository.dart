import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskRepository {
  final Box<Map> taskBox;

  TaskRepository(this.taskBox);

  Future<List<Task>> getAllTasks() async {
    final data = taskBox.values.toList();
    return data
        .map((map) => Task.fromMap(map.cast<String, dynamic>()))
        .toList();
  }

  Future<void> addTask(Task task) async {
    await taskBox.add(task.toMap());
  }

  Future<void> deleteTask(int index) async {
    await taskBox.deleteAt(index);
  }

  Future<String> startEditTaskRep(int index) async {
    final task = taskBox.getAt(index) as Map<String, dynamic>;
    return task['title'];
  }

  Future<void> toggleTask(int index) async {
    final task = taskBox.getAt(index) as Map<String, dynamic>;
    final updatedTask = Task.fromMap(task);

    final newTask = updatedTask.copyWith(isCompleted: !updatedTask.isCompleted);
    await taskBox.putAt(index, newTask.toMap());
  }
}
