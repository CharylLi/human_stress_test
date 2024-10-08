import 'package:human_stress_test/models/drawing.dart';
import 'package:human_stress_test/providers/drawing_provider.dart';
import 'package:human_stress_test/models/draw_actions/draw_actions.dart';
import 'package:flutter/material.dart';

class DrawingPainter extends CustomPainter {
  final Drawing _drawing;
  final DrawingProvider _provider;

  DrawingPainter(DrawingProvider provider)
      : _drawing = provider.drawing,
        _provider = provider;

  // This method is used to paint each action on the canvas
  // parameters:
  //  canvas: the canvas to paint on
  //  size: the size of the canvas
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    canvas.clipRect(rect); // make sure we don't scribble outside the lines.

    final erasePaint = Paint()..blendMode = BlendMode.clear;
    canvas.drawRect(rect, erasePaint);

    for (final action in _provider.drawing.drawActions) {
      _paintAction(canvas, action, size);
    }

    _paintAction(canvas, _provider.pendingAction, size);
  }

  // This method is used to paint the actions on the canvas
  // parameters:
  //  canvas: the canvas to paint on
  //  action: the action to paint
  //  size: the size of the canvas
  void _paintAction(Canvas canvas, DrawAction action, Size size) {
    final Rect rect = Offset.zero & size;
    final erasePaint = Paint()..blendMode = BlendMode.clear;

    switch (action) {
      case NullAction _:
        break;
      case ClearAction _:
        canvas.drawRect(rect, erasePaint);
        break;
      case LineAction lineAction:
        final paint = Paint()
          ..color = lineAction.color
          ..strokeWidth = 2;
        canvas.drawLine(lineAction.point1, lineAction.point2, paint);
        break;
      case OvalAction ovalAction:
        final paint = Paint()
          ..color = ovalAction.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        final rect = Rect.fromPoints(ovalAction.point1, ovalAction.point2);
        canvas.drawOval(rect, paint);
        break;
      case StrokeAction strokeAction:
        final paint = Paint()
          ..color = strokeAction.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        final path = Path();
        for (int i = 0; i < strokeAction.points.length - 1; i++) {
          path.moveTo(strokeAction.points[i].dx, strokeAction.points[i].dy);
          path.lineTo(
              strokeAction.points[i + 1].dx, strokeAction.points[i + 1].dy);
        }
        canvas.drawPath(path, paint);
        break;
      case RectangleAction rectangleAction:
        final paint = Paint()
          ..color = rectangleAction.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        final rect =
            Rect.fromPoints(rectangleAction.point1, rectangleAction.point2);
        canvas.drawRect(rect, paint);
        break;
      case TriangleAction triangleAction:
        // using the two points in triangleAction, we can calculate the third point
        final paint = Paint()
          ..color = triangleAction.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        final path = Path();
        path.moveTo(triangleAction.point1.dx, triangleAction.point1.dy);
        path.lineTo(triangleAction.point2.dx, triangleAction.point2.dy);
        path.lineTo(
            triangleAction.point1.dx +
                (triangleAction.point2.dx - triangleAction.point1.dx) / 2,
            triangleAction.point2.dy);
        path.lineTo(triangleAction.point1.dx, triangleAction.point1.dy);
        canvas.drawPath(path, paint);
        break;
      default:
        throw UnimplementedError('Action not implemented: $action');
    }
  }

  // This method checks if the DrawingPainter should repaint the canvas by comparing the old and new Drawing
  // parameters:
  //  oldDelegate: the old DrawingPainter
  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return oldDelegate._drawing != _drawing;
  }
}
