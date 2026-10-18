import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tic_tac_toe/core/utils/bloc/theme/theme_bloc.dart';
import 'package:tic_tac_toe/core/utils/theme/app_theme.dart';

import 'core/domain/routing/app_router.dart';
import 'core/utils/bloc_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProviders.items,
      // providers: blocProviders,
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, themeBloc) {
          return ScreenUtilInit(
            designSize: const Size(414, 896),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                /// UI
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeBloc,

                /// Navigation
                routerConfig: AppRouter.router,

                /// Other
                debugShowCheckedModeBanner: false,
                title: 'Tic Tac Toe',
              );
            },
          );
        },
      ),
    );
  }
}
