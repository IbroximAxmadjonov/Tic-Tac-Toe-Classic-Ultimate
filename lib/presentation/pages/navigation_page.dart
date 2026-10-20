import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/theme_extension.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => navigationShell.goBranch(value),
        items: [
          BottomNavigationBarItem(
            // icon: AppAssets.icons.bottomBar.shop.svg(),
            // label: context.t.home.title,
            icon: Icon(Icons.home_outlined, color: colorScheme.primary),
            label: 'Grid',
          ),
          BottomNavigationBarItem(
            // icon: AppAssets.icons.bottomBar.explore.svg(),
            // label: context.t.explore.title,
            icon: Icon(Icons.bar_chart, color: colorScheme.primary),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            // icon: AppAssets.icons.bottomBar.cart.svg(),
            // label: context.t.cart.title,
            icon: Icon(Icons.access_time_outlined, color: colorScheme.primary),
            label: 'History',
          ),
          BottomNavigationBarItem(
            // icon: AppAssets.icons.bottomBar.account.svg(),
            // label: context.t.profile.title,
            icon: Icon(Icons.settings, color: colorScheme.primary),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
