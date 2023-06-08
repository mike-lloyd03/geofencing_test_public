import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class GeofencesScreen extends StatefulWidget {
  const GeofencesScreen({super.key});

  @override
  State<GeofencesScreen> createState() => _GeofencesScreenState();
}

class _GeofencesScreenState extends State<GeofencesScreen> {
  List<bg.Geofence>? _geofences;

  Future<void> getGeofences() async {
    var gf = await bg.BackgroundGeolocation.geofences;
    setState(() {
      _geofences = gf;
    });
  }

  @override
  void initState() {
    super.initState();
    getGeofences();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: getGeofences,
              child: const Text("Refresh"),
            ),
          ],
        ),
        Table(
          border: TableBorder.all(),
          children: _geofences
                  ?.map((geofence) => TableRow(children: <Widget>[
                        TableCell(child: Text(geofence.identifier)),
                        TableCell(child: Text(geofence.latitude.toString())),
                        TableCell(child: Text(geofence.longitude.toString())),
                        TableCell(child: Text(geofence.radius.toString())),
                      ]))
                  .toList() ??
              [],
        ),
      ],
    );
  }
}
