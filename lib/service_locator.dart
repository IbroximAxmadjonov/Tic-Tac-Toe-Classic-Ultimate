import 'package:get_it/get_it.dart';

import 'data/data_base/app_database.dart';
import 'domain/repositories/main_repository.dart';
import 'presentation/manager/home_bloc/home_bloc.dart';
import 'presentation/manager/players_bloc/players_bloc.dart';
import 'presentation/manager/setting_bloc/setting_bloc.dart';
import 'presentation/manager/statics_provider/statics_provider.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  sl.registerLazySingleton<MainRepository>(() => MainRepository(db: sl()));
  sl.registerLazySingleton<HomeBloc>(
    () => HomeBloc(mainRepository: sl(), settingBloc: sl(), staticsProvider: sl()),
  );
  sl.registerLazySingleton<SettingBloc>(() => SettingBloc());
  sl.registerLazySingleton<StaticsProvider>(() => StaticsProvider());
  sl.registerLazySingleton<PlayersBloc>(
    () => PlayersBloc(mainRepository: sl(), staticsProvider: sl()),
  );
}
