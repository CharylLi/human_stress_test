import 'package:flutter/material.dart';

import '../draw_actions.dart';

// Used to represent a line segment drawn by the user
class LineAction extends DrawAction {
  // The two points that define the line
  final Offset point1;
  final Offset point2;
  // The color of the line
  final Color color;

  LineAction(this.point1, this.point2, this.color);
}
