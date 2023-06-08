import 'package:flutter/material.dart';
import 'package:geofencing_test/logs_screen.dart';

import 'events_screen.dart';
import 'geofences_screen.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  NavState createState() => NavState();
}

class NavState extends State<Nav> {
  Widget activePage = const EventsScreen();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Geofencing Test"),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Items'),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Events"),
                onTap: () {
                  setState(() {
                    activePage = const EventsScreen();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.gps_fixed),
                title: const Text("Geofences"),
                onTap: () {
                  setState(() {
                    activePage = const GeofencesScreen();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text("Log"),
                onTap: () {
                  setState(() {
                    activePage = const LogScreen();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: activePage,
      );
    });
  }
}
