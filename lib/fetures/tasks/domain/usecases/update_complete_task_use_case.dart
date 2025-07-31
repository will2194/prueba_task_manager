import 'package:prueba_task_manager/fetures/tasks/domain/repositories/task_repository.dart';

class UpdateCompleteTaskUseCase {
  final TaskRepository repository;

  UpdateCompleteTaskUseCase(this.repository);

  Future<void> call(int id, bool completed) async {
    return repository.updateCompleteTask(id, completed);
  }
}
