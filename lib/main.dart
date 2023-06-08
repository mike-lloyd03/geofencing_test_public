import 'package:flutter/material.dart';
import 'package:geofencing_test/event.dart';
import 'package:geofencing_test/events_screen.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:geofencing_test/geofences.dart';

import 'geofences_screen.dart';
import 'logs_screen.dart';
import 'nav.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geofencing Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Geofencing Test'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void registerGeofences() async {
    await bg.BackgroundGeolocation.addGeofences(geofences);
  }

  @override
  void initState() {
    super.initState();

    registerGeofences();

    bg.BackgroundGeolocation.onGeofence((geofenceEvent) {
      var action = geofenceEvent.action;
      var name = geofenceEvent.extras?["name"] ?? "NO NAME";
      var description = "$action geofence '$name'";
      var event = Event(
        description: description,
        time: DateTime.now().toUtc(),
      );
      event.create();
    });

    bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 10.0,
      stopOnTerminate: false,
      startOnBoot: true,
      debug: true,
      logLevel: bg.Config.LOG_LEVEL_VERBOSE,
    )).then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.startGeofences();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Geofencing Test", initialRoute: "/", routes: {
      "/": (context) => const Nav(),
      "/events": (context) => const EventsScreen(),
      "/geofences": (context) => const GeofencesScreen(),
      "/log": (context) => const LogScreen(),
    });
  }
}
