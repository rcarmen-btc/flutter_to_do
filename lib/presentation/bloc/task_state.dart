import '../../data/models/task.dart';

abstract class TaskState {
  const TaskState();
}

class TaskInitial extends TaskState {
  const TaskInitial();
}

class TaskLoading extends TaskState {
  const TaskLoading();
}

class StartEditTaskState extends TaskState {
  final String title;

  const StartEditTaskState(this.title);
}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);
}
