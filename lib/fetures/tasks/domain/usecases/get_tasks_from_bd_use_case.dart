import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTasksFromBdUseCase {
  final TaskRepository repository;

  GetTasksFromBdUseCase(this.repository);

  Future<List<Task>> call() async {
    final tasks = await repository.getTasksFromDb();

    return tasks;
  }
}
