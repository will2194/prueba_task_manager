import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> saveTasks(List<Task> tasks);
  Future<List<Task>> getTasksFromDb();
  Future<void> updateCompleteTask(int id, bool completed);
  Future<void> updateTask(Task task);
}
