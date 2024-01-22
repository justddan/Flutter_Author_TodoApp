import 'package:author_todo/controller/todo_controller.dart';
import 'package:author_todo/model/todo_model.dart';
import 'package:flutter/material.dart';

class OngoingTodoItem extends StatefulWidget {
  final TodoModel model;
  final int index;
  const OngoingTodoItem({
    super.key,
    required this.model,
    required this.index,
  });

  @override
  State<OngoingTodoItem> createState() => _OngoingTodoItemState();
}

class _OngoingTodoItemState extends State<OngoingTodoItem> {
  late final TextEditingController textEditingController =
      TextEditingController();
  bool isEdit = false;

  void toggleEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  void editCompleted(String value) {
    if (value.isNotEmpty) {
      TodoController.to.editTodo(widget.model, value);
      textEditingController.clear();
      toggleEdit();
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: isEdit
          ? TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Edit Todo',
                isDense: true,
                contentPadding: EdgeInsets.zero,
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: textEditingController.text.isNotEmpty
                          ? () {
                              editCompleted(textEditingController.text);
                            }
                          : null,
                      child: const Icon(Icons.check_rounded),
                    ),
                    InkWell(
                      onTap: toggleEdit,
                      child: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
              onFieldSubmitted: (value) {
                editCompleted(value);
              },
            )
          : Row(
              children: [
                ReorderableDragStartListener(
                  index: widget.index,
                  child: const Icon(Icons.drag_handle),
                ),
                Text(
                  widget.model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
      trailing: isEdit
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    TodoController.to.completeTodo(widget.model);
                  },
                  child: const Icon(
                    Icons.task_alt_rounded,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    textEditingController.text = widget.model.title;
                    toggleEdit();
                  },
                  child: const Icon(
                    Icons.edit_rounded,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    TodoController.to.deleteOngoingTodo(widget.model);
                  },
                  child: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
    );
  }
}
