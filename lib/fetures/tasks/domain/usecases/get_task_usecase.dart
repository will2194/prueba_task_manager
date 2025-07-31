import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<Task>> call() async {
    final tasks = await repository.getTasks();
    await repository.saveTasks(tasks);
    return tasks;
  }
}
