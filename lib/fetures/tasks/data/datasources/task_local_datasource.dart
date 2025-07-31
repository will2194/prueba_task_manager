import 'package:prueba_task_manager/core/database/task_database.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/mappers/task_mapper.dart';

class TaskLocalDatasource {
  final db = TaskDatabase.instance;

  Future<void> saveTasks(List<Task> tasks) async {
    final tasksModel = tasks.map((task) => task.toModel()).toList();
    await db.insertTasks(tasksModel);
  }

  Future<List<Task>> getTasks() async {
    final tasks = await db.getTasks();
    return tasks.map((task) => task.toEntity()).toList();
  }

  Future<void> updateCompleteTask(int id, bool completed) async {
    await db.updateCompleteTask(id, completed);
  }

  Future<void> updateTask(Task task) async {
    await db.updateTask(task.id!, task.toModel());
  }
}
