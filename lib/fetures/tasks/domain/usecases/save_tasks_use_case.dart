import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/repositories/task_repository.dart';

class SaveTasksUseCase {
  final TaskRepository repository;

  SaveTasksUseCase(this.repository);

  Future<void> call(List<Task> tasks) async {
    return repository.saveTasks(tasks);
  }
}
