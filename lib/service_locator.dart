import 'package:get_it/get_it.dart';

import 'data/data_base/app_database.dart';
import 'domain/repositories/main_repository.dart';
import 'presentation/manager/main_bloc/main_bloc.dart';
import 'presentation/manager/theme_bloc/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  sl.registerLazySingleton<MainRepository>(() => MainRepository(db: sl()));
  sl.registerLazySingleton<MainBloc>(() => MainBloc(mainRepository: sl()));
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
}
