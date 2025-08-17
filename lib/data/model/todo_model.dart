class Todo {
  final int id;
  final String title;
  final String description;
  final int priority;
  final bool complete;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.complete,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      complete: json['complete'],
    );
  }

  Todo copyWith({
    String? title,
    String? description,
    int? priority,
    bool? complete,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      complete: complete ?? this.complete,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'complete': complete,
    };
  }
}
