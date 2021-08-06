import 'package:flutter/material.dart';

/// Represents a Task. A task can have a title and description.
@immutable
class Task {
  Task({this.title = '', this.description = '', this.isComplete = false});

  /// Creates a task from the given map.
  Task.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? '',
        description = map['description'] ?? '',
        isComplete = map['isComplete'] == 'true';

  /// Returns this task as a map.
  Map<String, dynamic> get asMap => {
        'title': title,
        'description': description,
        'isComplete': isComplete.toString(),
      };

  /// The title of the task.
  final String title;

  /// The description of the task.
  final String description;

  /// Whether the task is complete or not.
  final bool isComplete;
}
