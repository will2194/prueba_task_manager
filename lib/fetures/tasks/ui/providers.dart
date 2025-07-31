import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/fetures/tasks/data/datasources/task_api_datasource.dart';
import 'package:prueba_task_manager/fetures/tasks/data/datasources/task_local_datasource.dart';
import 'package:prueba_task_manager/fetures/tasks/data/repositories/task_repository_impl.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/repositories/task_repository.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/usecases/get_task_usecase.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/usecases/get_tasks_from_bd_use_case.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/usecases/update_complete_task_use_case.dart';
import 'package:prueba_task_manager/fetures/tasks/ui/viewmodels/task_view_model.dart';

final taskApiDatasourceProvider = Provider<TaskApiDatasource>((ref) {
  return TaskApiDatasource();
});

final taskLocalDatasourceProvider = Provider<TaskLocalDatasource>((ref) {
  return TaskLocalDatasource();
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final taskApiDatasource = ref.watch(taskApiDatasourceProvider);
  final taskLocalDatasource = ref.watch(taskLocalDatasourceProvider);
  return TaskRepositoryImpl(taskApiDatasource, taskLocalDatasource);
});

final getTasksUseCaseProvider = Provider<GetTasksUseCase>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return GetTasksUseCase(taskRepository);
});

final getTasksFromBdUseCaseProvider = Provider<GetTasksFromBdUseCase>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return GetTasksFromBdUseCase(taskRepository);
});

final updateCompleteTaskUseCaseProvider = Provider<UpdateCompleteTaskUseCase>((
  ref,
) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return UpdateCompleteTaskUseCase(taskRepository);
});

final taskViewModelProvider =
    StateNotifierProvider<TaskViewModel, AsyncValue<List<Task>>>((ref) {
      final getTasksUseCase = ref.watch(getTasksUseCaseProvider);
      final getTasksFromBdUseCase = ref.watch(getTasksFromBdUseCaseProvider);
      final updateCompleteTaskUseCase = ref.watch(
        updateCompleteTaskUseCaseProvider,
      );
      return TaskViewModel(
        getTasksUseCase,
        getTasksFromBdUseCase,
        updateCompleteTaskUseCase,
      );
    });
