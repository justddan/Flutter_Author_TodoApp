import 'package:author_todo/controller/todo_controller.dart';
import 'package:author_todo/model/todo_model.dart';
import 'package:flutter/material.dart';

class CompletedTodoItem extends StatelessWidget {
  final TodoModel model;
  const CompletedTodoItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .3,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model.title),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  TodoController.to.deleteTodo(model);
                },
                child: const Icon(
                  Icons.delete,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
