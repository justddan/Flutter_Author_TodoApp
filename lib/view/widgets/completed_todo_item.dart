import 'package:author_todo/controller/todo_controller.dart';
import 'package:author_todo/model/todo_model.dart';
import 'package:flutter/material.dart';

class CompletedTodoItem extends StatelessWidget {
  final TodoModel model;
  final int index;
  const CompletedTodoItem({
    super.key,
    required this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        tileColor: Colors.white,
        title: Row(
          children: [
            ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle),
            ),
            Text(
              model.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            TodoController.to.deleteCompletedTodo(model);
          },
          child: const Icon(
            Icons.delete,
          ),
        ));
  }
}
