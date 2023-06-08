import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  String? eventLog;
  var scrollCtl = ScrollController();

  @override
  void initState() {
    super.initState();
    getLog();
  }

  Future<void> getLog() async {
    var tempLog = await bg.Logger.getLog();
    setState(() {
      eventLog = tempLog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: getLog,
              child: const Text("Refresh"),
            ),
            ElevatedButton(
              onPressed: () => {bg.Logger.emailLog("")},
              child: const Text("Email log"),
            ),
            ElevatedButton(
              onPressed: () =>
                  {scrollCtl.jumpTo(scrollCtl.position.maxScrollExtent)},
              child: const Text("Go to end"),
            ),
            const ElevatedButton(
              onPressed: bg.Logger.destroyLog,
              child: Text("Clear"),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: scrollCtl,
            child: Text(
              eventLog ?? "Fetching...",
            ),
          ),
        ),
      ],
    );
  }
}
