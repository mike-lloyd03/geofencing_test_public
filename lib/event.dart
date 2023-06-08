import 'package:geofencing_test/db.dart';

class Event {
  int id;
  String description;
  DateTime time;

  Event({
    this.id = 0,
    required this.description,
    required this.time,
  }) : super();

  factory Event.fromMap(Map<String, dynamic> map) => Event(
        id: map["id"],
        description: map["description"],
        time: DateTime.parse(map["time"]).toLocal(),
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "time": time.toIso8601String(),
      };

  Future<void> create() async {
    final db = await getDb();

    id = await db.insert(
      "events",
      toMap(),
    );
  }

  Future<void> delete() async {
    final db = await getDb();

    await db.delete(
      "events",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteAll() async {
    final db = await getDb();

    await db.delete(
      "events",
    );
  }

  static Future<List<Event>> getAll({String? where}) async {
    final db = await getDb();

    final List<Map<String, dynamic>> events =
        await db.query("events", where: where);

    return events.map((e) => Event.fromMap(e)).toList();
  }
}
