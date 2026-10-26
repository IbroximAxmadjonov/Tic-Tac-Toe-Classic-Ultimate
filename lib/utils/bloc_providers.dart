import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../service_locator.dart';
import '../presentation/manager/main_bloc/main_bloc.dart';
import '../presentation/manager/statics_provider/statics_provider.dart';
import '../presentation/manager/theme_bloc/theme_bloc.dart';

final class AppBlocProviders {
  static List<SingleChildWidget> get items => [
    BlocProvider<ThemeBloc>(create: (context) => sl<ThemeBloc>()),
    BlocProvider<MainBloc>(
      create: (context) => sl<MainBloc>()..add(LoadMainEvent()),
    ),
    ChangeNotifierProvider(create: (context) => sl<StaticsProvider>()),
  ];
}
