// This is a custom widget that prompts the user to draw a shape based on an index from a sequence of shapes and colors.
// The user must draw the correct shape and color to proceed to the next shape in the sequence.
// If the user makes a mistake, the game resets and the user must start over.

import 'package:flutter/material.dart';

import '../models/memory_game.dart';
import '../models/draw_actions/draw_actions.dart';
import 'draw_area.dart';
import 'palette.dart';
import 'package:provider/provider.dart';
import 'package:human_stress_test/providers/drawing_provider.dart';
import 'memory_game_result_view.dart';
import 'package:human_stress_test/providers/memory_game_provider.dart';

// This is a custom widget that prompts the user to draw a shape based on an index from a sequence of shapes and colors
// The user must draw the correct shape and color to proceed to the next shape in the sequence
// If the user makes a mistake, the game resets and the user must start over
class MemoryGameQuestionView extends StatefulWidget {
  final MemoryGame currGame;

  // this constructor initializes the MemoryGameQuestionView with a MemoryGame object
  const MemoryGameQuestionView({super.key, required this.currGame});

  @override
  // ignore: library_private_types_in_public_api
  _MemoryGameQuestionViewState createState() => _MemoryGameQuestionViewState();
}

// This is the state for the MemoryGameQuestionView widget
// It will keep track of the current game and the current index in the sequence
class _MemoryGameQuestionViewState extends State<MemoryGameQuestionView> {
  late MemoryGame _memoryGame;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _memoryGame = widget.currGame;
  }

  // This method checks the user's input against the current shape and color in the sequence
  // If the user's input is correct, the game proceeds to the next shape in the sequence
  // If the user's input is incorrect, or if they have completed the sequence, they are sent to the result screen
  void _checkUserInput(DrawAction action) {
    MemoryGameProvider memoryGameProvider =
        Provider.of<MemoryGameProvider>(context, listen: false);
    if (_memoryGame.checkAction(_currentIndex, action)) {
      setState(() {
        _currentIndex++;
        memoryGameProvider.currScore = _currentIndex;
        if (_currentIndex == _memoryGame.sequence.length) {
          // go to the result screen
          memoryGameProvider.updateRecords();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MemoryGameResultView(
                      score: _memoryGame.sequence.length)));
        }
      });
    } else {
      // go to the result screen
      memoryGameProvider.updateRecords();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MemoryGameResultView(score: _currentIndex)));
    }
  }

  @override
  // This method builds the MemoryGameQuestionView widget
  // it should be wrapped in a consumer for the MemoryGameProvider
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drawing Board'), actions: <Widget>[
        IconButton(
          icon: Semantics(
            label: 'Clear',
            child: const Icon(Icons.clear),
          ),
          onPressed: () => _clear(context),
        ),
        IconButton(
          icon: Semantics(
            label: 'Undo',
            child: const Icon(Icons.undo),
          ),
          onPressed: () => _undo(context),
        ),
        IconButton(
          icon: Semantics(
            label: 'Redo',
            child: const Icon(Icons.redo),
          ),
          onPressed: () => _redo(context),
        ),
      ]),
      drawer: Drawer(
        child: Palette(context),
      ),
      body: Center(
        child: Consumer<MemoryGameProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Prompt the user to draw the current index's shape
                // wrap the text in a fitted box
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                      'Draw shape ${_currentIndex + 1} of the sequence:',
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 2.0)),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: const DrawArea(width: 400, height: 400),
                ),
                // submit button to check the user's input
                Semantics(
                  button: true,
                  child: FloatingActionButton(
                    onPressed: () {
                      // get the current drawing from the DrawingProvider
                      final drawing =
                          Provider.of<DrawingProvider>(context, listen: false)
                              .drawing;
                      // if the last draw action is not null, check the user's input
                      if (drawing.drawActions.isNotEmpty) {
                        _checkUserInput(drawing.drawActions.last);
                      }

                      // clear the drawing
                      _clear(context);
                    },
                    // Wrap the icon in a semantics widget
                    child: Semantics(
                      label: 'Submit',
                      child: const Icon(Icons.check),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      // add a button to navigate back to the main menu
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('Go back to Main Menu'),
        ),
      ),
      // add a text box to display the current score
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Score: ${Provider.of<MemoryGameProvider>(context).currScore}'),
        ],
      ),
    );
  }

  // This method clears the drawing
  void _clear(BuildContext context) {
    Provider.of<DrawingProvider>(context, listen: false).clear();
  }

  // This method undoes the last action
  void _undo(BuildContext context) {
    Provider.of<DrawingProvider>(context, listen: false).undo();
  }

  // This method redoes the last undone action
  void _redo(BuildContext context) {
    Provider.of<DrawingProvider>(context, listen: false).redo();
  }

  // This method builds a widget based on the DrawAction provided
  // OvalAction will be displayed as a circle, LineAction will be displayed as a square (for now)
  Widget _buildShape(DrawAction action, int index) {
    if (action is RectangleAction) {
      return Container(
        width: 50,
        height: 50,
        color: action.color,
      );
    } else if (action is OvalAction) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: action.color,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return Container();
    }
  }
}
