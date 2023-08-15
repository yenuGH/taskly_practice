class Task {
  String content;
  DateTime timestamp;
  bool completed;

  Task({
    required this.content,
    required this.timestamp,
    required this.completed,
  });

  factory Task.fromMap(Map task) {
    return Task(
      content: task["content"],
      timestamp: task["timestamp"],
      completed: task["completed"],
    );
  }

  Map toMap() {
    return {
      "content": content,
      "timestamp": timestamp,
      "completed": completed,
    };
  }
}
