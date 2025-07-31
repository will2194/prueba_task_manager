import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';

part 'task_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskModel extends Task {
  TaskModel({
    required super.id,
    required super.title,
    required super.completed,
  });

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  static List<TaskModel> fromJsonList(List<dynamic> list) => list
      .map((dynamic map) => TaskModel.fromJson(map as Map<String, dynamic>))
      .toList();

  factory TaskModel.fromDb(Map<String, dynamic> json) => TaskModel(
    id: json['id'],
    title: json['title'],
    completed: json['completed'] == 1,
  );

  Map<String, dynamic> toJsonDb() => {
    'id': id,
    'title': title,
    'completed': completed ? 1 : 0,
  };
}
