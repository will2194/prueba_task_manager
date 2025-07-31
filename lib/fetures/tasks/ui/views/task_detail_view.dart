import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_task_manager/fetures/tasks/domain/entities/task.dart';
import 'package:prueba_task_manager/fetures/tasks/ui/providers.dart';

class TaskDetailView extends ConsumerStatefulWidget {
  final Task? task;

  const TaskDetailView({super.key, this.task});

  @override
  ConsumerState<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends ConsumerState<TaskDetailView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _completed = widget.task?.completed ?? false;
  }

  void _saveTask() async {
    if (_formKey.currentState?.validate() ?? false) {
      final viewModel = ref.read(taskDetailViewModelProvider.notifier);
      final viewModelTask = ref.read(taskViewModelProvider.notifier);

      final isEditing = widget.task != null;

      final task = Task(
        id: widget.task?.id,
        title: _titleController.text.trim(),
        completed: _completed,
      );

      if (!isEditing) {
        await viewModel.saveTask(task);
      } else {
        await viewModel.updateTask(task);
      }

      viewModelTask.loadTasks();
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Task' : 'Nuevo Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                maxLines: 10,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Completado'),
                value: _completed,
                onChanged: (value) {
                  setState(() => _completed = value ?? false);
                },
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _saveTask,
                icon: const Icon(Icons.save),
                label: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
