import 'package:go_router/go_router.dart';

import '../../presentation/pages/main/grid_page.dart';
import '../../presentation/pages/history/history_page.dart';
import '../../presentation/pages/settings/settings_page.dart';
import '../../presentation/pages/statics/statics_page.dart';
import '../../presentation/pages/navigation_page.dart';

part 'route_name.dart';

part 'route_path.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutePath.home,
    routes: [
      // /// Splash
      // GoRoute(
      //   name: RouteName.splash,
      //   path: RoutePath.splash,
      //   builder: (context, state) => const SplashPage(),
      // ),

      // /// Auth
      // // On boarding start to enter
      // GoRoute(
      //   name: RouteName.onboarding,
      //   path: RoutePath.onboarding,
      //   builder: (context, state) => const OnBoardingPage(),
      // ),
      // // Auth page is select log in or sign up
      // GoRoute(
      //   name: RouteName.auth,
      //   path: RoutePath.auth,
      //   builder: (context, state) => const AuthPage(),
      // ),
      // // LogIn page if user already have account
      // GoRoute(
      //   name: RouteName.logIn,
      //   path: RoutePath.logIn,
      //   builder: (context, state) => const LogInPage(),
      // ),
      // // SignUp page if user don't have account
      // GoRoute(
      //   name: RouteName.signUp,
      //   path: RoutePath.signUp,
      //   builder: (context, state) => const SignUpPage(),
      // ),
      // // Send otp page for sign up
      // // GoRoute(
      // //   name: RouteName.sendOTP,
      // //   path: RoutePath.sendOTP,
      // //   builder: (context, state) => const SendOtpPage(),
      // // ),
      // // Verification page for sign up
      // // GoRoute(
      // //   name: RouteName.verification,
      // //   path: RoutePath.verification,
      // //   builder: (context, state) => const VerificationPage(),
      // // ),

      /// Main Routes
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.home,
                path: RoutePath.home,
                builder: (context, state) => const GridPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.statics,
                path: RoutePath.statics,
                builder: (context, state) => const StaticsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.history,
                path: RoutePath.history,
                builder: (context, state) => const HistoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.settings,
                path: RoutePath.settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),

      /// Other Routes
      // GoRoute(
      //   name: RouteName.search,
      //   path: RoutePath.search,
      //   builder: (context, state) => const SearchPage(),
      // ),
      // GoRoute(
      //   name: RouteName.selectLocation,
      //   path: RoutePath.selectLocation,
      //   builder: (context, state) => const SplashPage(),
      // ),
    ],
  );
}
