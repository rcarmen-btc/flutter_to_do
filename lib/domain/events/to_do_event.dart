abstract class ToDoEvent {
  const ToDoEvent();
}

class LoadTasks extends ToDoEvent {}

class AddTask extends ToDoEvent {
  final String title;

  const AddTask(this.title);
}

class DeleteTask extends ToDoEvent {
  final int index;

  const DeleteTask(this.index);
}

class ToggleTask extends ToDoEvent {
  final int index;

  const ToggleTask(this.index);
}
