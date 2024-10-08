// this is a custom widget that will be used to display the memory game
// it will generate and display the sequence of shapes and colors that the user has to remember

import 'package:flutter/material.dart';
import '../models/memory_game.dart';
import '../models/draw_actions/draw_actions.dart';
import 'memory_game_question_view.dart';
import 'package:provider/provider.dart';
import '../providers/memory_game_provider.dart';

// This is a custom widget that will be used to display the memory game
// It will generate and display the sequence of shapes and colors that the user has to remember
class MemoryGameView extends StatefulWidget {
  // This constructor takes in a MemoryGame object
  const MemoryGameView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MemoryGameViewState createState() => _MemoryGameViewState();
}

// This is the state for the MemoryGameView widget
// It will keep track of the current game and the current index in the sequence
class _MemoryGameViewState extends State<MemoryGameView> {
  late MemoryGame _memoryGame;

  @override
  void initState() {
    super.initState();

    _memoryGame = MemoryGame();
  }

  // this method will build a widget based on the DrawAction provided
  // this view will display the sequence of shapes and colors that the user has to remember
  // OvalAction will be displayed as a circle, LineAction will be displayed as a square (for now)
  // there's a button to navigate to the memory game question view, where the user will be prompted to draw the shapes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // make this text bigger
            //Text("Memorize this sequence from top to bottom", selectionColor: Colors.black,),
            const Text(
              "Memorize this sequence from top to bottom",
              style: TextStyle(fontSize: 20),
            ),

            // Display all the shapes in the sequence in a column, and each shape should have padding
            for (var action in _memoryGame.sequence)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildShapeWidget(action),
              ),

            // Add a button to navigate to the memory game question view
            Consumer<MemoryGameProvider>(
              builder: (context, provider, child) {
                return ElevatedButton(
                  onPressed: () {
                    provider.memoryGame = _memoryGame;
                    provider.currScore = 0;
                    provider.currentIndex = 0;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MemoryGameQuestionView(
                                  currGame: _memoryGame,
                                )));
                  },
                  child: const Text('Go to Memory Game Question'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // This method will build a widget based on the DrawAction provided
  // OvalAction will be displayed as a circle, RectangleAction will be displayed as a square
  Widget _buildShapeWidget(DrawAction action) {
    // check the type of the action and build the appropriate widget
    if (action is RectangleAction) {
      // create a label for the shape based on its color
      String label = '';
      if (action.color == Colors.red) {
        label += 'Red';
      } else if (action.color == Colors.green) {
        label += 'Green';
      } else if (action.color == Colors.blue) {
        label += 'Blue';
      } else if (action.color == const Color.fromARGB(255, 251, 205, 68)) {
        label += 'Yellow';
      } else {
        label += 'Unknown';
      }
      label += ' Square';

      return Semantics(
        label: label,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: action.color,
            shape: BoxShape.rectangle,
          ),
        ),
      );
    } else if (action is OvalAction) {
      // create a label for the shape based on its color
      String label = '';
      if (action.color == Colors.red) {
        label += 'Red';
      } else if (action.color == Colors.green) {
        label += 'Green';
      } else if (action.color == Colors.blue) {
        label += 'Blue';
      } else if (action.color == const Color.fromARGB(255, 251, 205, 68)) {
        label += 'Yellow';
      } else {
        label += 'Unknown';
      }
      label += ' Circle';

      return Semantics(
        label: label,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: action.color,
            shape: BoxShape.circle,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
