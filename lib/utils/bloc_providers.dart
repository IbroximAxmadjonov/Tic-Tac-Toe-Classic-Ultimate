import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service_locator.dart';
import '../presentation/manager/main_bloc/main_bloc.dart';
import '../presentation/manager/theme_bloc/theme_bloc.dart';

final class AppBlocProviders {
  static List<BlocProvider> get items => [
    BlocProvider<ThemeBloc>(create: (context) => sl<ThemeBloc>()),
    BlocProvider<MainBloc>(create: (context) => sl<MainBloc>()),
  ];
}
