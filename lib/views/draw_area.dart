import 'package:human_stress_test/providers/drawing_provider.dart';
import 'package:human_stress_test/models/draw_actions/draw_actions.dart';
import 'package:human_stress_test/models/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawing_painter.dart';

// This is the main widget that the user interacts with to draw on the screen.
class DrawArea extends StatelessWidget {
  // constructor for DrawArea
  const DrawArea({super.key, required this.width, required this.height});

  // width and height of the drawing area
  final double width, height;

  // This method builds the DrawArea widget.
  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, unchangingChild) {
        return CustomPaint(
          size: Size(width, height),
          painter: DrawingPainter(drawingProvider),
          child: GestureDetector(
              onPanStart: (details) => _panStart(details, drawingProvider),
              onPanUpdate: (details) => _panUpdate(details, drawingProvider),
              onPanEnd: (details) => _panEnd(details, drawingProvider),
              child: Container(
                  width: width,
                  height: height,
                  color: Colors.transparent,
                  child: unchangingChild)),
        );
      },
    );
  }

  // This method craetes a new DrawAction based on the current tool and the user's touch position.
  // parameters:
  // details - the details of the user's touch event
  // drawingProvider - the DrawingProvider that contains the current tool and color selected by the user
  void _panStart(DragStartDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;

    switch (currentTool) {
      case Tools.none:
        drawingProvider.pendingAction = NullAction();
        break;
      case Tools.line:
        drawingProvider.pendingAction = LineAction(
          details.localPosition,
          details.localPosition,
          drawingProvider.colorSelected,
        );
        break;
      case Tools.oval:
        drawingProvider.pendingAction = OvalAction(
          details.localPosition,
          details.localPosition,
          drawingProvider.colorSelected,
        );
        break;
      case Tools.stroke:
        List<Offset> points = [details.localPosition];
        drawingProvider.pendingAction = StrokeAction(
          points,
          drawingProvider.colorSelected,
        );
        break;
      case Tools.rectangle:
        drawingProvider.pendingAction = RectangleAction(
          details.localPosition,
          details.localPosition,
          drawingProvider.colorSelected,
        );
        break;
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }

  // This method updates the current DrawAction while the user is drawing.
  // parameters:
  // details - the details of the user's touch event
  // drawingProvider - the DrawingProvider that contains the current tool and color selected by the user
  void _panUpdate(DragUpdateDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;

    switch (currentTool) {
      case Tools.none:
        break;
      case Tools.line:
        final pendingAction = drawingProvider.pendingAction as LineAction;
        drawingProvider.pendingAction = LineAction(
          pendingAction.point1,
          details.localPosition,
          pendingAction.color,
        );
        break;
      case Tools.oval:
        final pendingAction = drawingProvider.pendingAction as OvalAction;
        drawingProvider.pendingAction = OvalAction(
          pendingAction.point1,
          details.localPosition,
          pendingAction.color,
        );
        break;
      case Tools.stroke:
        final pendingAction = drawingProvider.pendingAction as StrokeAction;
        pendingAction.points.add(details.localPosition);
        drawingProvider.pendingAction = StrokeAction(
          pendingAction.points,
          pendingAction.color,
        );
        break;
      case Tools.rectangle:
        final pendingAction = drawingProvider.pendingAction as RectangleAction;
        drawingProvider.pendingAction = RectangleAction(
          pendingAction.point1,
          details.localPosition,
          pendingAction.color,
        );
        break;
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }

  // This method adds the current DrawAction to the list of past actions when the user stops drawing.
  // parameters:
  // details - the details of the user's touch event
  // drawingProvider - the DrawingProvider that contains the current tool and color selected by the user
  void _panEnd(DragEndDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;

    switch (currentTool) {
      case Tools.none:
        break;
      case Tools.line:
      case Tools.oval:
      case Tools.stroke:
        drawingProvider.add(drawingProvider.pendingAction);
        drawingProvider.pendingAction = NullAction();
        break;
      case Tools.rectangle:
        drawingProvider.add(drawingProvider.pendingAction);
        drawingProvider.pendingAction = NullAction();
        break;
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }
}
