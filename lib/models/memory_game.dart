// this is the model class for the memory game
// it will keep track of the sequence of shapes and colors that the user has to remember

import '/models/draw_actions/draw_actions.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class MemoryGame {
  // sequence should be a list of draw actions
  final List<DrawAction> sequence;

  // the constructor should generate a random sequence of draw actions to use as sequence
  MemoryGame() : sequence = generateSequence();

  // this method will check if a provided draw action matches a particular index in the sequence
  bool checkAction(int index, DrawAction action) {
    if (sequence[index].runtimeType != action.runtimeType) {
      return false;
    }
    // if the action is a rectangle, check only the color
    if (action is RectangleAction) {
      return (sequence[index] as RectangleAction).color == action.color;
    }
    // if the action is a circle, check only the color
    if (action is OvalAction) {
      return (sequence[index] as OvalAction).color == action.color;
    }
    return false;
  }
}

// this method will generate a random sequence of draw actions
List<DrawAction> generateSequence() {
  final List<DrawAction> sequence = [];

  // these are the colors that will be used in the sequence
  final List<Color> presetColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    const Color.fromARGB(255, 251, 205, 68)
  ];

  // default offset values for line actions
  const Offset defaultOffset = Offset(0, 0);

  for (var i = 0; i < 5; i++) {
    // generate a random numberconst  between 0 and 1 to determine shape
    final random1 = Random().nextDouble();
    // generate a random number to determine which preset color to use
    final random2 = Random().nextInt(4);
    // evenly distribute the chance of generating an oval or rectangle
    if (random1 < 0.5) {
      sequence.add(
          RectangleAction(defaultOffset, defaultOffset, presetColors[random2]));
    } else {
      sequence
          .add(OvalAction(defaultOffset, defaultOffset, presetColors[random2]));
    }
  }
  return sequence;
}
