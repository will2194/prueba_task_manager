import 'package:prueba_task_manager/fetures/tasks/data/datasources/task_api_datasource.dart';
import 'package:prueba_task_manager/fetures/tasks/data/datasources/task_local_datasource.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskApiDatasource api;
  final TaskLocalDatasource db;

  TaskRepositoryImpl(this.api, this.db);

  @override
  Future<List<Task>> getTasks() async {
    return await api.fetchTasks();
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    await db.saveTasks(tasks.cast());
  }

  @override
  Future<List<Task>> getTasksFromDb() async {
    return await db.getTasks();
  }

  @override
  Future<void> updateCompleteTask(int id, bool completed) async {
    await db.updateCompleteTask(id, completed);
  }
}
