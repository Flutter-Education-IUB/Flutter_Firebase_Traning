import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: provider.player1Controller,
              decoration: InputDecoration(labelText: "Player 1 Name"),
              onChanged: (value) => provider.updateNames(),
            ),

            TextField(
              controller: provider.player2Controller,
              decoration: InputDecoration(labelText: "Player 2 Name"),
              onChanged: (value) => provider.updateNames(),
            ),

            SizedBox(height: 20),

            Text("Player 1 Wins: ${provider.xWins}"), // FIXED
            Text("Player 2 Wins: ${provider.oWins}"), // FIXED
            Text("Ties: ${provider.ties}"),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                provider.startNewGame();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => GameScreen(
                          player1: provider.player1Controller.text,
                          player2: provider.player2Controller.text,
                        ),
                  ),
                );
              },
              child: Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }
}
