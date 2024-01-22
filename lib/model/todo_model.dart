import 'dart:convert';

class TodoModel {
  String id;
  String title;
  bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> jsonData) {
    return TodoModel(
      id: jsonData['id'],
      title: jsonData['title'],
      isCompleted: jsonData['isCompleted'],
    );
  }

  static Map<String, dynamic> toMap(TodoModel todo) => {
        'id': todo.id,
        'title': todo.title,
        'isCompleted': todo.isCompleted,
      };

  static String encode(List<TodoModel> todos) => json.encode(
        todos
            .map<Map<String, dynamic>>((todo) => TodoModel.toMap(todo))
            .toList(),
      );

  static List<TodoModel> decode(String todos) =>
      (json.decode(todos) as List<dynamic>)
          .map<TodoModel>((item) => TodoModel.fromJson(item))
          .toList();
}
