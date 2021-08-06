import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twillo_strip_down/business/models/task.dart';

// The provider for this database.
final taskProvider = StateNotifierProvider((ref) => TaskNotifier());

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void add(Task task) => state = [...state, task];

  List<Task> get taskList => state;
}
