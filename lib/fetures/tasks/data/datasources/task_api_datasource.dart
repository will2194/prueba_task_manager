import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_task_manager/core/values/string_values.dart';
import 'package:prueba_task_manager/fetures/tasks/data/models/task_model.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/mappers/task_mapper.dart';

class TaskApiDatasource {
  Future<List<Task>> fetchTasks() async {
    final res = await http.get(
      Uri.parse(apiBaseUrl),
      headers: {'Content-Type': 'application/json'},
    );
    final List data = json.decode(res.body);
    final tasks = data.map((json) => TaskModel.fromJson(json)).toList();

    return tasks.map((task) => task.toEntity()).toList();
  }
}
