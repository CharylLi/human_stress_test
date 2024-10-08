import 'package:flutter/material.dart';

import '../draw_actions.dart';


// This is used to represent a single continuous path drawn by the user, 
// for example, if they put their finger down, wiggled it around, and let go.
class StrokeAction extends DrawAction {
  // The points that define the path
  final List<Offset> points;
  // The color of the path
  final Color color;

  StrokeAction(this.points, this.color);
}
