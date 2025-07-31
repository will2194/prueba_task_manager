import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_task_manager/core/values/string_values.dart';
import 'package:prueba_task_manager/fetures/tasks/data/models/task_model.dart';

class TaskApiDatasource {
  Future<List<TaskModel>> fetchTasks() async {
    final res = await http.get(
      Uri.parse(apiBaseUrl),
      headers: {'Content-Type': 'application/json'},
    );
    final List data = json.decode(res.body);
    return data.map((json) => TaskModel.fromJson(json)).toList();
  }
}
