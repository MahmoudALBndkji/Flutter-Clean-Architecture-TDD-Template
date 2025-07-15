import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        title: Text(task.title),
        minVerticalPadding: 20,
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd MMM y').format(task.createdAt),
              ),
              Text(task.tag),
            ],
          ),
        ),
      ),
    );
  }
}
