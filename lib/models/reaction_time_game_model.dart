import 'dart:math';

/// A model class that handles the core logic for the reaction time game.
class ReactionTimeGameModel {
  DateTime? startTime;
  DateTime? endTime;
  final Random _random = Random();

  /// Starts the reaction time timer.
  /// Records the current time as the start time.
  void start() {
    startTime = DateTime.now();
  }

  /// Stops the reaction time timer.
  /// Records the current time as the end time.
  void stop() {
    endTime = DateTime.now();
  }

  /// Calculates the reaction time duration.
  /// Returns the difference between the end time and start time.
  /// If either time is null, returns a zero duration.
  Duration get reactionTime {
    if (startTime == null || endTime == null) {
      return Duration.zero;
    }
    return endTime!.difference(startTime!);
  }

  /// Generates a random delay between 1000 and 6000 milliseconds.
  /// This delay is used to make the game start at a random time.
  int get randomDelay {
    return _random.nextInt(4000) + 2000;
  }
}
