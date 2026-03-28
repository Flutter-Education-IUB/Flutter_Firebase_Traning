import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyRef = FirebaseFirestore.instance.collection("matches");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Match History"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              // DELETE ALL HISTORY
              final docs = await historyRef.get();
              for (var doc in docs.docs) {
                await doc.reference.delete();
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("All history cleared")),
              );
            },
          ),
        ],
      ),

      body: StreamBuilder(
        stream: historyRef.orderBy("timestamp", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No match history yet",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final matches = snapshot.data!.docs;

          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final data = matches[index].data();
              final p1 = data["player1"];
              final p2 = data["player2"];
              final winner = data["winner"];
              final time = (data["timestamp"] as Timestamp).toDate();

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  leading: Icon(
                    winner == "Tie"
                        ? Icons.horizontal_rule
                        : Icons.emoji_events,
                    color: winner == "Tie" ? Colors.orange : Colors.green,
                    size: 32,
                  ),
                  title: Text("$p1 vs $p2"),
                  subtitle: Text(
                    "Winner: $winner\n${time.toString().substring(0, 16)}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
