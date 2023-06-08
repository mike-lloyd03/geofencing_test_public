import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

final geofences = [
  bg.Geofence(
    identifier: "Dublin",
    latitude: 53.34972,
    longitude: -6.26028,
    radius: 150,
    notifyOnEntry: true,
    notifyOnExit: true,
    notifyOnDwell: true,
  ),
  bg.Geofence(
    identifier: "Tokyo",
    latitude: 35.652832,
    longitude: 139.839478,
    radius: 150,
    notifyOnEntry: true,
    notifyOnExit: true,
    notifyOnDwell: true,
  ),
  bg.Geofence(
    identifier: "Jakarta",
    latitude: -6.175110,
    longitude: 106.865039,
    radius: 150,
    notifyOnEntry: true,
    notifyOnExit: true,
    notifyOnDwell: true,
  ),
];
