import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/task.dart';
import '../../data/repository/task_repository.dart';
import '../../domain/events/to_do_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<ToDoEvent, TaskState> {
    final TaskRepository repository;

    TaskBloc(this.repository) : super(const TaskInitial()) {
        on<LoadTasks>(_onLoadTasks);
        on<AddTask>(_onAddTask);
        on<DeleteTask>(_onDeleteTask);
        on<ToggleTask>(_onToggleTask);
        on<StartEditTask>(_onStartEditTask);
    }

    Future<void> _onLoadTasks(LoadTasks event, Emitter emit) async {
        emit(const TaskLoading());
        try {
            final tasks = await repository.getAllTasks();
            emit(TaskLoaded(tasks));
        } catch (e) {
            emit(TaskError('Loading error: $e'));
        }
    }

    Future<void> _onAddTask(AddTask event, Emitter emit) async {
      try {
        final newTask = Task(
            id: DateTime.now().millisecondsSinceEpoch, 
            title: event.title,
            isCompleted: false,
        );
          await repository.addTask(newTask);
          add(LoadTasks());
      } catch (e) {
        emit(TaskError('Creating task error: $e'));
      }
    }

    Future<void> _onStartEditTask(StartEditTask event, Emitter emit) async {
      try {
        final String new_title = await repository.startEditTaskRep(event.index);
        emit(StartEditTaskState(new_title));
      } catch (e) {
        emit(TaskError('Start editing error: $e'));
      }
    }

    Future<void> _onDeleteTask(DeleteTask event, Emitter emit) async {
        try {
            await repository.deleteTask(event.index);
            add(LoadTasks());
        } catch (e) {
            emit(TaskError('Delete error: $e'));
        }
    }

    
    Future<void> _onToggleTask(ToggleTask event, Emitter emit) async {
        try {
            await repository.toggleTask(event.index);
            add(LoadTasks());
        } catch (e) {
            emit(TaskError('Toggle error: $e'));
        }
    }

}