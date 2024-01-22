import 'package:author_todo/model/todo_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoController extends GetxController {
  static TodoController get to => Get.find();

  var ongoingTodos = <TodoModel>[].obs;
  var completedTodos = <TodoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTodo();
  }

  Future<void> getTodo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String todoString = prefs.getString('todo_key') ?? "";
    if (todoString != "") {
      final result = todoString.split("^");

      ongoingTodos.value = TodoModel.decode(result[0]);
      completedTodos.value = TodoModel.decode(result[1]);
    }
  }

  Future<void> saveTodo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedOngoingTodo = TodoModel.encode(ongoingTodos);
    final String encodedCompletedTodo = TodoModel.encode(completedTodos);
    await prefs.setString(
        'todo_key', "$encodedOngoingTodo^$encodedCompletedTodo");
  }

  void addTodo(TodoModel todo) {
    ongoingTodos.add(todo);
    saveTodo();
  }

  void completeTodo(TodoModel todo) {
    int index = ongoingTodos.indexWhere((element) => element.id == todo.id);
    ongoingTodos.removeAt(index);
    completedTodos.add(todo);
    saveTodo();
  }

  void deleteOngoingTodo(TodoModel todo) {
    int index = ongoingTodos.indexWhere((element) => element.id == todo.id);
    ongoingTodos.removeAt(index);
    saveTodo();
  }

  void deleteCompletedTodo(TodoModel todo) {
    int index = completedTodos.indexWhere((element) => element.id == todo.id);
    completedTodos.removeAt(index);
    saveTodo();
  }

  void editTodo(TodoModel todo, String value) {
    int index = ongoingTodos.indexWhere((element) => element.id == todo.id);
    ongoingTodos[index] = todo.copyWith(
      title: value,
    );
    saveTodo();
  }

  void reorderOngoingTodo(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = ongoingTodos.removeAt(oldIndex);
    ongoingTodos.insert(newIndex, item);
  }

  void reorderCompletedTodo(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = completedTodos.removeAt(oldIndex);
    completedTodos.insert(newIndex, item);
  }
}
