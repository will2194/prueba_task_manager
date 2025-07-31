import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/usecases/get_task_usecase.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/usecases/get_tasks_from_bd_use_case.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/usecases/update_complete_task_use_case.dart';

enum Filter { all, complete, incomplete }

class TaskViewModel extends StateNotifier<AsyncValue<List<Task>>> {
  final GetTasksUseCase getTasksUseCase;
  final GetTasksFromBdUseCase getTasksFromBdUseCase;
  final UpdateCompleteTaskUseCase updateCompleteTaskUseCase;

  List<Task> taskList = [];

  Filter _currentFilter = Filter.all;
  Filter get currentFilter => _currentFilter;

  TaskViewModel(
    this.getTasksUseCase,
    this.getTasksFromBdUseCase,
    this.updateCompleteTaskUseCase,
  ) : super(const AsyncLoading()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = const AsyncLoading();
    try {
      var tasks = await getTasksFromBdUseCase();
      if (tasks.isEmpty) {
        tasks = await getTasksUseCase();
      }

      taskList = tasks;
      state = AsyncData(tasks);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> toggleCompleted(Task task, bool completed) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      completed: completed,
    );

    await updateCompleteTaskUseCase(task.id!, updatedTask.completed);

    final updatedList = [
      for (final t in state.value!)
        if (t.id == task.id) updatedTask else t,
    ];

    state = AsyncData(updatedList);
  }

  void toggleFilter(Filter filter) {
    _currentFilter = filter;
    _applySort();
  }

  void _applySort() {
    switch (_currentFilter) {
      case Filter.all:
        loadTasks();
        break;
      case Filter.complete:
        state = AsyncData(getFilterTasks(true));
        break;
      case Filter.incomplete:
        state = AsyncData(getFilterTasks(false));
        break;
    }
  }

  List<Task> getFilterTasks(bool complete) {
    List<Task> outputList = taskList
        .where((task) => task.completed == complete)
        .toList();
    return outputList;
  }
}
