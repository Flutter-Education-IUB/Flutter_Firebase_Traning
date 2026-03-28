import 'package:flutter/material.dart';
import '../models/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameProvider extends ChangeNotifier {
  // Text controllers
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  // Player names
  String player1Name = "Player 1";
  String player2Name = "Player 2";

  // Scoreboard
  int xWins = 0;
  int oWins = 0;
  int ties = 0;

  // Game data
  List<String> board = List.filled(9, "");
  String currentTurn = "X";
  String winner = "";
  String startingPlayer = "X";

  // Update player names
  void updateNames() {
    player1Name =
        player1Controller.text.isEmpty ? "Player 1" : player1Controller.text;

    player2Name =
        player2Controller.text.isEmpty ? "Player 2" : player2Controller.text;

    notifyListeners();
  }

  // Start NEW match
  void startNewGame() {
    board = List.filled(9, "");
    winner = "";
    currentTurn = startingPlayer;
    notifyListeners();
  }

  // Switch who starts
  void toggleStartingPlayer() {
    startingPlayer = (startingPlayer == "X") ? "O" : "X";
    startNewGame();
  }

  // Play a move
  void playMove(int index) {
    if (board[index] != "" || winner != "") return;

    board[index] = currentTurn;

    // Check winner
    if (_checkWinner(currentTurn)) {
      winner = currentTurn;

      if (winner == "X") xWins++;
      if (winner == "O") oWins++;

      // SAVE WINNER MATCH
      FirebaseFirestore.instance
          .collection("matches")
          .add(
            MatchModel(
              player1: player1Name,
              player2: player2Name,
              board: board,
              winner: winner,
              startingPlayer: startingPlayer == "X" ? 1 : 2,
              timestamp: Timestamp.now(),
            ).toMap(),
          );

      notifyListeners();
      return;
    }

    // Tie
    if (!board.contains("")) {
      winner = "Tie";
      ties++;

      // SAVE TIE MATCH
      FirebaseFirestore.instance
          .collection("matches")
          .add(
            MatchModel(
              player1: player1Name,
              player2: player2Name,
              board: board,
              winner: "Tie",
              startingPlayer: startingPlayer == "X" ? 1 : 2,
              timestamp: Timestamp.now(),
            ).toMap(),
          );

      notifyListeners();
      return;
    }

    // Switch turn
    currentTurn = (currentTurn == "X") ? "O" : "X";
    notifyListeners();
  }

  // Winner logic
  bool _checkWinner(String p) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] == p &&
          board[pattern[1]] == p &&
          board[pattern[2]] == p) {
        return true;
      }
    }
    return false;
  }
}
