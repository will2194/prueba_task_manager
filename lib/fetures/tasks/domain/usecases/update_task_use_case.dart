import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<void> call(Task task) async {
    return repository.updateTask(task);
  }
}
