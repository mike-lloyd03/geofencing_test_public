import 'package:flutter/material.dart';

import 'event.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<Event>? _events;

  void _createEvent() {
    Event event = Event(
      id: 0,
      description: "new event",
      time: DateTime.now().toUtc(),
    );
    event.create();
    loadEvents();
  }

  void loadEvents() async {
    List<Event> events = await Event.getAll();
    setState(() {
      _events = events;
    });
  }

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: _createEvent,
              child: const Text("Create Event"),
            ),
            ElevatedButton(
              onPressed: loadEvents,
              child: const Text("Refresh"),
            ),
            ElevatedButton(
              onPressed: () {
                Event.deleteAll();
                loadEvents();
              },
              child: const Text("Clear Table"),
            ),
          ],
        ),
        Table(
          border: TableBorder.all(),
          children: _events
                  ?.map((e) => TableRow(children: <Widget>[
                        TableCell(child: Text("${e.id}")),
                        TableCell(child: Text(e.description)),
                        TableCell(child: Text(e.time.toString())),
                      ]))
                  .toList() ??
              [],
        ),
      ],
    );
  }
}
