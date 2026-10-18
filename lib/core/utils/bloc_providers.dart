import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/grid/presentation/manager/grid_block.dart';
import 'bloc/theme/theme_bloc.dart';

final class AppBlocProviders {
  static List<BlocProvider> get items => [
    BlocProvider(create: (_) => ThemeBloc()),
    BlocProvider(create: (_) => GridBlock()),
  ];
}

// final List<BlocProvider> blocProviders = [
//   BlocProvider(create: (_) => ThemeBloc()),
//   BlocProvider(create: (_) => GridBlock()),
// ];

// final List<SingleChildWidget> blocProviders = [
//   BlocProvider(create: (_) => ThemeBloc()),
//   BlocProvider(create: (_) => GridBlock()),
// ];

// List<SingleChildWidget> get blocProviders => [
//   BlocProvider(create: (_) => ThemeBloc()),
//   BlocProvider(create: (_) => GridBlock()),
// ];
