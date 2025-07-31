import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/usecases/save_tasks_use_case.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/usecases/update_task_use_case.dart';

class TaskDetailViewModel extends StateNotifier<AsyncValue<bool>> {
  final SaveTasksUseCase saveTasksUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  TaskDetailViewModel(this.saveTasksUseCase, this.updateTaskUseCase)
    : super(const AsyncLoading());

  Future<void> saveTask(Task task) async {
    await saveTasksUseCase.call([task]);

    state = AsyncData(true);
  }

  Future<void> updateTask(Task task) async {
    await updateTaskUseCase.call(task);

    state = AsyncData(true);
  }
}
