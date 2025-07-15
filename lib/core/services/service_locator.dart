import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/datasources/task_data_source.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/repos/task_repository_impl.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/repos/task_repository.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/usecases/create_task_use_case.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/usecases/get_all_tasks_use_case.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/cubits/task/task_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerFactory(
    () => TaskCubit(getAllTasksUseCase: sl(), createTaskUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetAllTasksUseCase(sl()));
  sl.registerLazySingleton(() => CreateTaskUseCase(sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));
  sl.registerLazySingleton<TaskDataSource>(() => TaskRemoteDataSource(sl()));
  sl.registerLazySingleton(() => http.Client());
}
