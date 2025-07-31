import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/core/database/task_database.dart';
import 'package:prueba_task_manager/fetures/tasks/ui/views/task_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TaskDatabase.instance.database;

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TaskView(),
    );
  }
}
