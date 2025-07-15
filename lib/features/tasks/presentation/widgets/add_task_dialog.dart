import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/cubits/task/task_cubit.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 300,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'title'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: tagController,
              decoration: const InputDecoration(labelText: 'tag'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    context.read<TaskCubit>().createTask(
                          title: titleController.text,
                          tag: tagController.text,
                          createdAt: DateTime.now(),
                        );
                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
