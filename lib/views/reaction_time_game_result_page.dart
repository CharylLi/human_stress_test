import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reaction_time_game_provider.dart';
import 'reaction_time_game_page.dart';

/// A StatefulWidget that displays the result of the reaction time game.
/// Shows the user's reaction time and provides an option to retry the game.
class ReactionTimeGameResultPage extends StatefulWidget {
  final int reactionTime; // The reaction time in milliseconds.

  const ReactionTimeGameResultPage({super.key, required this.reactionTime});

  @override
  // ignore: library_private_types_in_public_api
  _ReactionTimeGameResultPageState createState() =>
      _ReactionTimeGameResultPageState();
}

/// State class for ReactionTimeGameResultPage, managing the UI and interactions.
class _ReactionTimeGameResultPageState
    extends State<ReactionTimeGameResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(139, 219, 250, 1),
        title: const Text("Reaction Time Game"),
        leading: Semantics(
          button: true,
          label: 'Go back',
          hint: 'Tap to navigate back to the main screen',
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the reaction time result.
            Semantics(
              label: 'Reaction time result',
              hint: 'Displays the user\'s reaction time in milliseconds.',
              child: Text(
                'Your reaction time is ${widget.reactionTime} ms',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            // Retry button to play the game again.
            Semantics(
              button: true,
              label: 'Retry button',
              hint: 'Tap to retry the reaction time game.',
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Provider.of<ReactionTimeGameProvider>(context, listen: false)
                      .resetGame();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReactionTimeGamePage()),
                  );
                },
                child: const Text('Retry'),
              ),
            ),
            const SizedBox(height: 10),
            // Back to Main Page button.
            Semantics(
              button: true,
              label: 'Back to Main Page button',
              hint: 'Tap to go back to the main page.',
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Back to Main Page'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
