import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/routing/app_router.dart';
import 'generated/slang/slang.g.dart';
import 'presentation/manager/setting_bloc/setting_bloc.dart';
import 'service_locator.dart' as di;

import 'utils/bloc_providers.dart';
import 'utils/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ),
  );

  await di.initDependencies();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MultiBlocProvider(
        providers: AppBlocProviders.items,
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, settingState) {
            return Builder(
              builder: (context) {
                return ScreenUtilInit(
                  designSize: const Size(414, 896),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (context, child) {
                    return MaterialApp.router(
                      /// UI
                      theme: AppTheme.light,
                      darkTheme: AppTheme.dark,
                      themeMode: settingState.themeMode,

                      /// Localization
                      locale: TranslationProvider.of(context).flutterLocale,
                      supportedLocales: AppLocaleUtils.instance.supportedLocales,
                      localizationsDelegates: GlobalMaterialLocalizations.delegates,

                      /// Navigation
                      routerConfig: AppRouter.router,

                      /// Other
                      debugShowCheckedModeBanner: false,
                      title: 'Tic Tac Toe',
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
