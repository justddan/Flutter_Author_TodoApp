import 'package:author_todo/model/todo_model.dart';
import 'package:author_todo/view/widgets/completed_todo_item.dart';
import 'package:flutter/material.dart';

class CompletedPage extends StatelessWidget {
  final List<TodoModel> todos;
  const CompletedPage({
    super.key,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return CompletedTodoItem(
          model: todos[index],
        );
      },
    );
  }
}
