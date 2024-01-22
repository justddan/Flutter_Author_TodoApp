import 'dart:convert';

class TodoModel {
  String id;
  String title;

  TodoModel({
    required this.id,
    required this.title,
  });

  TodoModel copyWith({
    String? id,
    String? title,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> jsonData) {
    return TodoModel(
      id: jsonData['id'],
      title: jsonData['title'],
    );
  }

  static Map<String, dynamic> toMap(TodoModel todo) => {
        'id': todo.id,
        'title': todo.title,
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
