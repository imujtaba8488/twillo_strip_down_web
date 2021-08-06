import 'package:flutter/material.dart';
import 'task.dart';

/// Represents a collection of tasks.
@immutable
class TaskCollection {
  const TaskCollection({this.name = '', this.tasks = const []});

  /// Creates a task collection from the given map.
  TaskCollection.fromMap(Map<String, dynamic> map)
      : name = map['name'] ?? '',
        tasks = map['tasks'].map((task) => Task.fromMap(task)).toList();

  /// Returns the task collection as a map.
  Map<String, dynamic> get asMap => {
        'name': name,
        'tasks': tasks.map((task) => task.asMap).toList(),
      };

  /// The name of the collection.
  final String name;

  /// The list of all tasks in this collection.
  final List<Task> tasks;
}
