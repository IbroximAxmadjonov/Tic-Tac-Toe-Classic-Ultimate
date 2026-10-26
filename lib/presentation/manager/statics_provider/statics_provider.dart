import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';

class StaticsProvider extends ChangeNotifier {
  List<PlayerEntity> _players = [];
  List<PlayerEntity> get players => _players;

  void getAllPlayers(List<PlayerEntity> players){
    _players = players;
    notifyListeners();
  }
}