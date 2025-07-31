import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/fetures/tasks/ui/providers.dart';
import 'package:prueba_task_manager/fetures/tasks/ui/viewmodels/task_view_model.dart';
import 'package:prueba_task_manager/fetures/tasks/ui/views/task_detail_view.dart';

class TaskView extends ConsumerWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskViewModelProvider);
    final viewModel = ref.read(taskViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          PopupMenuButton<Filter>(
            onSelected: (filter) {
              viewModel.toggleFilter(filter);
            },
            icon: const Icon(Icons.filter_list, color: Colors.black),
            color: Colors.white,
            iconSize: 40,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: Filter.all,
                child: Text(
                  'Todos',
                  style: TextStyle(
                    color: viewModel.currentFilter == Filter.all
                        ? Colors.deepPurple
                        : null,
                  ),
                ),
              ),
              PopupMenuItem(
                value: Filter.complete,
                child: Text(
                  'Completos',
                  style: TextStyle(
                    color: viewModel.currentFilter == Filter.complete
                        ? Colors.deepPurple
                        : null,
                  ),
                ),
              ),
              PopupMenuItem(
                value: Filter.incomplete,
                child: Text(
                  'Incompletos',
                  style: TextStyle(
                    color: viewModel.currentFilter == Filter.incomplete
                        ? Colors.deepPurple
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: tasksAsync.when(
        data: (tasks) => ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, i) {
            final task = tasks[i];
            return ListTile(
              title: Text(task.title),
              trailing: Checkbox(
                value: task.completed,
                onChanged: (value) {
                  viewModel.toggleCompleted(task, !task.completed);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TaskDetailView(task: task)),
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TaskDetailView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
