import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:human_stress_test/models/records/position_record_entry.dart';
import 'package:human_stress_test/models/records/position_records.dart';

class PositionProvider extends ChangeNotifier {
  // keep track of all play history
  final PositionRecords _records;

  double latitude = 0;
  double longitude = 0;
  bool known = false;
  final stopwatch = Stopwatch();

  //starting point when the game starts
  bool? started;
  double startLatitude = 0;
  double startLongtitude = 0;
  double distance = 0;

  double _finalTime = 0;

  PositionRecords get records => _records;

  PositionProvider(Box<PositionRecordEntry> storage)
      : _records = PositionRecords(records: [], storage: storage) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      try {
        var value = await _determinePosition();
        longitude = value.longitude;
        latitude = value.latitude;
        known = true;
        notifyListeners();
      } catch (error) {
        known = false;
        notifyListeners(); // Notify listeners about the error state
      }
    });
  }

  startPositTrack() {
    started = true;
    stopwatch.start();
    startLatitude = latitude;
    startLongtitude = longitude;
    notifyListeners();
  }

  endPositTracking() {
    if (started != null && started == true) {
      stopwatch.stop();
      started = false;
      distance = distanceInMeters();
      // meter per seconds
      _finalTime = distance * 1000 / stopwatch.elapsedMilliseconds;

      _records.upsertEntry(PositionRecordEntry(speed: finalTime));

      notifyListeners();
    }
  }

  double get finalTime => _finalTime;

  resetTracking() {
    stopwatch.reset();
    started = null;
    distance = 0;
    startLatitude = 0;
    startLongtitude = 0;
  }

  double distanceInMeters() {
    return 111139 *
        sqrt((startLatitude - latitude) * (startLatitude - latitude) +
            (startLongtitude - longitude) * (startLongtitude - longitude));
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
