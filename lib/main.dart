import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd_template/core/services/service_locator.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/cubits/task/task_cubit.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/screens/tasks_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Clean Architecture TDD Template',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 48, 158, 208),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => sl<TaskCubit>(),
        child: TasksHome(),
      ),
    );
  }
}
