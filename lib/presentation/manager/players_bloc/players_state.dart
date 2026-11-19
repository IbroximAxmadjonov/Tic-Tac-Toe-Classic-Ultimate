part of 'players_bloc.dart';

class PlayersState extends Equatable {
  final List<PlayerEntity> playersList;

  const PlayersState({required this.playersList});

  @override
  List<Object?> get props => [playersList];
}
