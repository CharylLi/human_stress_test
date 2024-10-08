import 'package:flutter/material.dart';
import '../draw_actions.dart';

// Used to represent a rectangle drawn by the user
class RectangleAction extends DrawAction {
  // The two points that define the rectangle
  final Offset point1;
  final Offset point2;
  // The color of the rectangle
  final Color color;

  RectangleAction(this.point1, this.point2, this.color);
  
}