import 'package:flutter/material.dart';
import 'package:human_stress_test/providers/memory_game_provider.dart';
import 'package:human_stress_test/providers/position_provider.dart';
import 'package:human_stress_test/providers/reaction_time_game_provider.dart';
import 'package:provider/provider.dart';

class LeaderBoardView extends StatelessWidget {
  const LeaderBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        buildRowWithWidgets([
          Semantics(
            label: 'Game Icon',
            child: const Icon(Icons.games),
          ),
          Semantics(
            label: 'Games Header',
            child: const Text(
              'Games',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Semantics(
            label: 'Best Score Header',
            child: const Text(
              'Best Score',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Semantics(
            label: 'Games Played Header',
            child: const Text(
              'Games Played',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ]),
        Consumer<MemoryGameProvider>(
          builder: (context, provider, child) {
            String bestScore = provider.records
                .findHighestScorePercentage()
                .toStringAsFixed(2);
            return buildRowWithWidgets([
              Semantics(
                label: 'Drawing Memory Icon',
                child: const Icon(Icons.brush),
              ),
              Semantics(
                label: 'Drawing Memory Game',
                child: const Text('Drawing Memory'),
              ),
              Semantics(
                label: 'Best Score for Drawing Memory',
                child: Text('$bestScore%'),
              ),
              Semantics(
                label: 'Games Played for Drawing Memory',
                child: Text('${provider.records.getEntries.length}'),
              ),
            ]);
          },
        ),
        Consumer<ReactionTimeGameProvider>(
          builder: (context, provider, child) {
            int bestScore = provider.records.findfastestReactionTime();
            return buildRowWithWidgets([
              Semantics(
                label: 'Reaction Time Icon',
                child: const Icon(Icons.timer),
              ),
              Semantics(
                label: 'Reaction Time Game',
                child: const Text('Reaction Time'),
              ),
              Semantics(
                label: 'Best Score for Reaction Time',
                child: Text('$bestScore ms'),
              ),
              Semantics(
                label: 'Games Played for Reaction Time',
                child: Text('${provider.records.getEntries.length}'),
              ),
            ]);
          },
        ),
        Consumer<PositionProvider>(
          builder: (context, provider, child) {
            double bestScore = provider.records.findFastestSpeed();
            return buildRowWithWidgets([
              Semantics(
                label: 'Running Icon',
                child: const Icon(Icons.directions_run),
              ),
              Semantics(
                label: 'Running Game',
                child: const Text('Running'),
              ),
              Semantics(
                label: 'Best Speed for Running',
                child: Text('$bestScore m/s'),
              ),
              Semantics(
                label: 'Games Played for Running',
                child: Text('${provider.records.getEntries.length}'),
              ),
            ]);
          },
        )
      ],
    );
  }

  Widget buildRowWithWidgets(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets.map((widget) {
          return Expanded(
            child: Column(
              children: [widget],
            ),
          );
        }).toList(),
      ),
    );
  }
}
