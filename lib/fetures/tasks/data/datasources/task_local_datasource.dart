import 'package:prueba_task_manager/core/database/task_database.dart';
import 'package:prueba_task_manager/fetures/tasks/data/models/task_model.dart';

class TaskLocalDatasource {
  final db = TaskDatabase.instance;

  Future<void> saveTasks(List<TaskModel> tasks) async {
    await db.insertTasks(tasks);
  }

  Future<List<TaskModel>> getTasks() async {
    return await db.getTasks();
  }

  Future<void> updateCompleteTask(int id, bool completed) async {
    await db.updateCompleteTask(id, completed);
  }
}
