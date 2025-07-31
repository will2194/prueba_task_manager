import 'package:prueba_task_manager/fetures/tasks/data/models/task_model.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';

extension TaskModelToEntity on TaskModel {
  Task toEntity() => Task(id: id, title: title, completed: completed);
}

extension TaskToModel on Task {
  TaskModel toModel() => TaskModel(id, title, completed);
}
