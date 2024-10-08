import 'package:flutter/material.dart';

import '../draw_actions.dart';

// Used to represent an oval drawn by the user
class OvalAction extends DrawAction {
  // The two points that define the oval  
  final Offset point1;
  final Offset point2;
  // The color of the oval
  final Color color;

  OvalAction(this.point1, this.point2, this.color);
  
}