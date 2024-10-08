import 'package:flutter/material.dart';

import '../models/draw_actions/draw_actions.dart';
import '../models/drawing.dart';
import '../models/tools.dart';

// This class is a ChangeNotifier that provides a Drawing object to the rest of the app.
// It has methods to add actions to the drawing, undo and redo actions, and clear the drawing.
// It also has properties to keep track of the current tool and color selected by the user.
// It also has a property to keep track of the current action being performed by the user.
class DrawingProvider extends ChangeNotifier {
  Drawing? _drawing; // used to create a cached drawing via replay of past actions
  // The current action being performed by the user
  DrawAction _pendingAction = NullAction();
  // The tool currently selected by the user
  Tools _toolSelected = Tools.none;
  // The color currently selected by the user
  Color _colorSelected = Colors.blue;

  // The list of actions that have been performed on the drawing
  final List<DrawAction> _pastActions;
  // The list of actions that have been undone and can be redone
  final List<DrawAction> _futureActions;

  // The width and height of the drawing area
  final double width;
  final double height;

  // Constructor for the DrawingProvider
  // parameters:
  // width - the width of the drawing area
  // height - the height of the drawing area
  DrawingProvider({required this.width, required this.height})
      : _pastActions = [],
        _futureActions = [];

  // Getter for the drawing
  Drawing get drawing {
    if (_drawing == null) {
      _createCachedDrawing();
    }
    return _drawing!;
  }

  // Setter for the pendingAction
  // This method sets the pendingAction and invalidates the drawing
  // parameters:
  // action - the action to set as the pending action
  set pendingAction(DrawAction action) {
    _pendingAction = action;
    _invalidateAndNotify();
  }

  // Getter for the pendingAction
  DrawAction get pendingAction => _pendingAction;

  // Setter for the toolSelected
  // This method sets the toolSelected and invalidates the drawing
  // parameters:
  // aTool - the tool to set as the selected tool
  set toolSelected(Tools aTool) {
    _toolSelected = aTool;
    _invalidateAndNotify();
  }

  // Getter for the toolSelected
  Tools get toolSelected => _toolSelected;

  // Setter for the colorSelected
  // This method sets the colorSelected and invalidates the drawing
  // This should be called whenever the user selects a new color
  set colorSelected(Color color) {
    _colorSelected = color;
    _invalidateAndNotify();
  }
  Color get colorSelected => _colorSelected;

  // This method creates a cached drawing by replaying all past actions
  // It is called whenever the drawing needs to be redrawn
  _createCachedDrawing() {
    _drawing = Drawing(_pastActions, width: width, height: height);
  }

  // This method invalidates the drawing and notifies listeners
  // It is called whenever the drawing needs to be redrawn
  _invalidateAndNotify() {
    _drawing = null;
    notifyListeners();
  }

  // This method adds an action to the list of past actions and clears the previous timeline of future actions
  // It is called whenever the user performs an action
  add(DrawAction action) {
    _pastActions.add(action);
    _futureActions.clear();
    _invalidateAndNotify();
  }

  // This method removes the last action from the list of past actions and adds it to the list of future actions, then invalidates the drawing
  undo() {
    if (_pastActions.isEmpty) return;
    DrawAction lastAction = _pastActions.removeLast();
    _futureActions.add(lastAction);
    _invalidateAndNotify();
  }

  // This method removes the last action from the list of future actions and adds it to the list of past actions, then invalidates the drawing
  redo() {
    if (_futureActions.isEmpty) return;
    DrawAction nextAction = _futureActions.removeLast();
    _pastActions.add(nextAction);
    _invalidateAndNotify();
  }

  // This methods adds a ClearAction to the list of past actions and clears the list of future actions, then invalidates the drawing
  clear() {
    _pastActions.add(ClearAction());
    _futureActions.clear();
    _invalidateAndNotify();
  }
}
