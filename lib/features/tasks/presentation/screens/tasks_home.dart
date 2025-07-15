import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/cubits/task/task_cubit.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/widgets/add_task_dialog.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/widgets/tasks_list_view.dart';

class TasksHome extends StatelessWidget {
  const TasksHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(50, 0, 0, 0),
        title: Text(
          "Tasks",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: TasksListView(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(50, 0, 0, 0),
        tooltip: "Add New Task",
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<TaskCubit>(),
              child: AddTaskDialog(),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
