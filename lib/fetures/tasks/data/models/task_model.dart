import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskModel {
  final int? id;
  final String title;
  final bool completed;

  TaskModel(this.id, this.title, this.completed);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  static List<TaskModel> fromJsonList(List<dynamic> list) => list
      .map((dynamic map) => TaskModel.fromJson(map as Map<String, dynamic>))
      .toList();

  factory TaskModel.fromDb(Map<String, dynamic> json) =>
      TaskModel(json['id'], json['title'], json['completed'] == 1);

  Map<String, dynamic> toJsonDb() => {
    'id': id,
    'title': title,
    'completed': completed ? 1 : 0,
  };
}
