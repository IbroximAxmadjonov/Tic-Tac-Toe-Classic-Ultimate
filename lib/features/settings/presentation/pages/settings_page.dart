import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/bloc/theme/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings Page')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Settings Page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<ThemeBloc>().add(
                  ThemeModeChanged(themeMode: ThemeMode.light),
                );
              },
              child: const Text('Light Theme'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<ThemeBloc>().add(
                  ThemeModeChanged(themeMode: ThemeMode.dark),
                );
              },
              child: const Text('Dark Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
