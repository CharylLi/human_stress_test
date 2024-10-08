import 'package:flutter/material.dart';

// This widget represents the result screen after the user has completed the memory game.
// It displays the user's score and a button to return to the game list view.
class MemoryGameResultView extends StatelessWidget {
  final int score;

  const MemoryGameResultView({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your score: $score'),
            ElevatedButton(
              onPressed: () {
                // pop 3 times to return to the game list view
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Return to Game List'),
            ),
          ],
        ),
      ),
    );
  }
}
