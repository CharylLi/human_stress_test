import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:human_stress_test/models/records/drawing_memory_record_entry.dart';
import 'package:human_stress_test/models/records/position_record_entry.dart';
import 'package:human_stress_test/providers/position_provider.dart';
import 'package:human_stress_test/providers/reaction_time_game_provider.dart';
import 'package:human_stress_test/views/leader_board.dart';
import 'package:human_stress_test/views/memory_game_view.dart';
import 'package:human_stress_test/views/reaction_time_game_page.dart';
import 'package:human_stress_test/views/running_game_page.dart';
import 'package:provider/provider.dart';
import 'package:human_stress_test/providers/memory_game_provider.dart';
import 'package:human_stress_test/providers/drawing_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/records/reaction_time_record_entry.dart';

Box<DrawingMemoryRecordEntry>? _storage1;
Box<ReactionTimeRecordEntry>? _storage2;
Box<PositionRecordEntry>? _storage3;

Future<Uint8List> addEncryption(
    String keyName, FlutterSecureStorage secureStorage) async {
  // if key not exists return null
  //check if key exists by reading into the secureStorage
  final encryptionKeyString = await secureStorage.read(key: 'key');
  //if null then generate a new one and write to secureStorage
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(key),
    );
  }
  //reread the key after generating
  final key = await secureStorage.read(key: 'key');
  //decode the key
  final encryptionKeyUint8List = base64Url.decode(key!);
  // ignore: avoid_print
  print('Encryption key Uint8List: $encryptionKeyUint8List');

  return encryptionKeyUint8List;
}

void main() async {
  //register for all adapters for each game
  Hive
    ..registerAdapter(ReactionTimeRecordAdapter())
    ..registerAdapter(DrawingMemoryRecordEntryAdapter())
    ..registerAdapter(PositionRecordEntryAdapter());

  //initialize Hive
  await Hive.initFlutter();
  const secureStorage = FlutterSecureStorage();

  var reactionTimeBox = await Hive.openBox<ReactionTimeRecordEntry>(
      'reactionTimeBox',
      encryptionCipher:
          HiveAesCipher(await addEncryption('key1', secureStorage)));
  var drawingMemoryBox = await Hive.openBox<DrawingMemoryRecordEntry>(
      'drawingMemoryBox',
      encryptionCipher:
          HiveAesCipher(await addEncryption('key2', secureStorage)));
  var positionBox = await Hive.openBox<PositionRecordEntry>('positionBox',
      encryptionCipher:
          HiveAesCipher(await addEncryption('key3', secureStorage)));

  _storage1 = drawingMemoryBox;
  _storage2 = reactionTimeBox;
  _storage3 = positionBox;
  runApp(
    // Wrap the app in a MultiProvider to provide the MemoryGameProvider and DrawingProvider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => MemoryGameProvider(_storage1!)),
        ChangeNotifierProvider(
            create: (context) => DrawingProvider(width: 400, height: 400)),
        ChangeNotifierProvider(
            create: (context) => ReactionTimeGameProvider(_storage2!)),
        ChangeNotifierProvider(
            create: (context) => PositionProvider(_storage3!)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Human Stress Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(61, 157, 242, 1)),
        useMaterial3: true,
      ),
      home: const NavDemo(title: 'Human Stress Test'),
    );
  }
}

class NavDemo extends StatefulWidget {
  const NavDemo({super.key, required this.title});
  final String title;

  @override
  State<NavDemo> createState() => _NavDemoState();
}

class _NavDemoState extends State<NavDemo> {
  // We will use this to keep track of what tab is selected
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(139, 219, 250, 1),
        title: Text(widget.title),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        indicatorColor: const Color.fromRGBO(139, 219, 250, 1),
        selectedIndex: _currentTabIndex,

        // This defines what is in the nav bar
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.leaderboard), label: 'Stats')
        ],
      ),

      // Here we choose how to populate the body using the current value of _currentTabIndex
      body: Center(
        child: _currentTabIndex == 0
            ? const GameListView()
            : const LeaderBoardView(),
      ),
    );
  }
}

class GameListView extends StatelessWidget {
  const GameListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Displays game options in a column
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MemoryGameView()), // Update to the drawing memory game page
              );
            },
            // Drawing Memory Game
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(76, 124, 39, 1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(30.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.brush,
                        color: Color.fromRGBO(76, 124, 39, 1), size: 25),
                  ),
                  SizedBox(height: 10), // Space between icon and text
                  Text(
                    'Drawing Memory',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<ReactionTimeGameProvider>(context, listen: false)
                  .startGame();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReactionTimeGamePage()),
              );
            },
            // Reaction Time Game
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(76, 124, 39, 1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(30.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.timer,
                        color: Color.fromRGBO(76, 124, 39, 1), size: 25),
                  ),
                  SizedBox(height: 10), // Space between icon and text
                  Text(
                    'Reaction Time',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RunningGamePage()),
              );
            },
            // Running Game
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(76, 124, 39, 1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(30.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.directions_run,
                        color: Color.fromRGBO(76, 124, 39, 1), size: 25),
                  ),
                  SizedBox(height: 10), // Space between icon and text
                  Text(
                    'Running game',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center, // Center game name
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
