import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/statics_provider/statics_provider.dart';

class StaticsPage extends StatelessWidget {
  const StaticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final players = context.watch<StaticsProvider>().players;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Statics Page'),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(player.name[0].toUpperCase())),
                  title: Text(player.name),
                  subtitle: Text(
                    'Games: ${player.games} | '
                    'Wins: ${player.wins} | '
                    'Losses: ${player.losses} | '
                    'Draws: ${player.draws}',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
