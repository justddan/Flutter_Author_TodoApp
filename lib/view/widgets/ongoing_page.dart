import 'package:author_todo/controller/todo_controller.dart';
import 'package:author_todo/model/todo_model.dart';
import 'package:author_todo/view/widgets/ongoing_todo_item.dart';
import 'package:flutter/material.dart';

class OngoingPage extends StatelessWidget {
  final List<TodoModel> todos;
  const OngoingPage({
    super.key,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(labelText: 'Add New Todo'),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                TodoController.to.addTodo(TodoModel(
                    id: "todoId_${TodoController.to.todos.length}",
                    title: value));
                textEditingController.clear();
              }
            },
          ),
        ),
        Expanded(
          child: ReorderableListView.builder(
            itemBuilder: (context, index) {
              return OngoingTodoItem(
                key: ValueKey("todo_$index"),
                model: todos[index],
                index: index,
              );
            },
            itemCount: todos.length,
            onReorder: TodoController.to.reorderTodo,
          ),
        ),
      ],
    );
  }
}
