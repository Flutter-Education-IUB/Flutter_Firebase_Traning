import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import 'history_screen.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;

  const GameScreen({super.key, required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _dialogShown = false; // 🔥 FIX: prevent multiple dialogs

  void _showResultDialog(String msg) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Game Over"),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _dialogShown = false; // 🔥 FIX: reset dialog flag
                  context.read<GameProvider>().startNewGame();
                },
                child: const Text("Play Again"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _dialogShown = false; // 🔥 reset
                },
                child: const Text("Close"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();

    // 🔥 FIX: Only show dialog once & ONLY when game ends
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_dialogShown && game.winner != "") {
        _dialogShown = true;

        String message =
            (game.winner == "X")
                ? "${widget.player1} (X) Wins!"
                : (game.winner == "O")
                ? "${widget.player2} (O) Wins!"
                : "It's a Tie!";

        _showResultDialog(message);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );
            },
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // PLAYER TURN
          Text(
            "Turn: ${game.currentTurn == 'X' ? widget.player1 : widget.player2} (${game.currentTurn})",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // GAME GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    game.playMove(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        game.board[index],
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color:
                              game.board[index] == "X"
                                  ? Colors.red
                                  : Colors.green,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // SCOREBOARD
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Column(
              children: [
                const Text(
                  "Scoreboard",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Text("X (${widget.player1}) Wins: ${game.xWins}"),
                Text("O (${widget.player2}) Wins: ${game.oWins}"),
                Text("Ties: ${game.ties}"),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _dialogShown = false; // 🔥 FIX
                        game.startNewGame();
                      },
                      child: const Text("Restart Match"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _dialogShown = false; // 🔥 FIX
                        game.toggleStartingPlayer();
                      },
                      child: const Text("Switch Starter"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
