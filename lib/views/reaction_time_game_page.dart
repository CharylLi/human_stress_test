import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reaction_time_game_provider.dart';
import 'reaction_time_game_result_page.dart';

/// A StatefulWidget that manages the reaction time game.
/// Initializes the game and handles the user interaction to stop the game
/// and navigate to the result page.
class ReactionTimeGamePage extends StatefulWidget {
  const ReactionTimeGamePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReactionTimeGamePageState createState() => _ReactionTimeGamePageState();
}

/// State class for ReactionTimeGamePage, managing the game logic and UI.
class _ReactionTimeGamePageState extends State<ReactionTimeGamePage> {
  @override
  void initState() {
    super.initState();
    // Start the game after the initial frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReactionTimeGameProvider>(context, listen: false).startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Consumer widget listens to changes in ReactionTimeGameProvider.
        child: Consumer<ReactionTimeGameProvider>(
          builder: (context, provider, child) {
            return GestureDetector(
              // Handle tap event to stop the game if ready.
              onTap: () {
                if (provider.isReady) {
                  provider.stopGame();
                  // Navigate to the result page with the reaction time.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReactionTimeGameResultPage(
                        reactionTime: provider.reactionTime.inMilliseconds,
                      ),
                    ),
                  );
                }
              },
              child: Semantics(
                button: true,
                label: provider.isReady ? 'Tap Now' : 'Get Ready',
                hint: provider.isReady
                    ? 'Tap the screen as fast as possible.'
                    : 'Wait for the signal to tap the screen.',
                child: Container(
                  color: provider.isReady ? Colors.green : Colors.red,
                  child: Center(
                    child: Text(
                      provider.isReady ? 'Tap Now!' : 'Get Ready...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
