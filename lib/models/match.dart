//lib/models/match.dart
import 'package:cloud_firestore/cloud_firestore.dart';

 class MatchModel {
  final String? id;
  final String player1;
  final String player2;
  final List<String> board;
  final String winner;
  final int startingPlayer;
  final Timestamp timestamp;

  MatchModel({
    this.id,
    required this.player1,
    required this.player2,
    required this.board,
    required this.winner,
    required this.startingPlayer,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'player1': player1,
      'player2': player2,
      'board': board,
      'winner': winner,
      'startingPlayer': startingPlayer,
      'timestamp': timestamp,
    };
  }

  factory MatchModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return MatchModel(
      id: id,
      player1: map['player1'] ?? '',
      player2: map['player2'] ?? '',
      board: List<String>.from(map['board'] ?? List.filled(9, '')),
      winner: map['winner'] ?? 'Tie',
      startingPlayer: map['startingPlayer'] ?? 1,
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }
 }
