import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/cubits/task/task_cubit.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/widgets/loading_column.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/widgets/task_card.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  @override
  void initState() {
    getAllTasks();
    super.initState();
  }

  void getAllTasks() async => await context.read<TaskCubit>().getAllTaks();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TasksError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is TaskCreated) {
          getAllTasks();
        }
      },
      builder: (context, state) {
        if (state is GettingTasks) {
          return LoadingColumn(message: 'Fetching Tasks');
        } else if (state is CreatingTask) {
          return LoadingColumn(message: 'Creating Tasks');
        } else if (state is TasksLoaded) {
          return state.tasks.isEmpty
              ? Center(
                  child: Text(
                  "Not Tasks Yet",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ))
              : ListView.builder(
                  itemExtent: 110,
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) =>
                      TaskCard(task: state.tasks[index]),
                );
        }
        return SizedBox.shrink();
      },
    );
  }
}
