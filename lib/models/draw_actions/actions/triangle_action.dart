import 'package:flutter/material.dart';
import '../draw_actions.dart';

// Used to represent a triangle drawn by the user
class TriangleAction extends DrawAction {
  // The two points that define the triangle
  // The triangle will be defined similarly to a rectangle, with the middle of the top side of the rectangle representing the top point
  // and the bottom two corners of the rectangle representing the bottom two points of the triangle
  final Offset point1;
  final Offset point2;
  // The color of the triangle
  final Color color;

  TriangleAction(this.point1, this.point2, this.color);
  
}