import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twillo_strip_down/business/models/task.dart';

/// Prototype of the database class supported by this system.
abstract class Database extends StateNotifier<List<Task>> {
  final List<Map<String, dynamic>> data = [];

  Database(Task state) : super([state]);

  /// Adds the given data to the database.
  Future<void> add(Task task);

  /// Retrieves the data from the database.
  List<Task> get tasks;
}
