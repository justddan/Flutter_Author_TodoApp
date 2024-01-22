import 'package:author_todo/model/todo_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoController extends GetxController {
  static TodoController get to => Get.find();

  RxList<TodoModel> todos = <TodoModel>[].obs;
  var items = List<String>.generate(10, (index) => 'Item $index').obs;

  var ongoingTodos = [];
  var completedTodos = [];

  @override
  void onInit() {
    super.onInit();
    getTodo();
  }

  Future<void> getTodo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String todoString = prefs.getString('todo_key')!;

    final result = TodoModel.decode(todoString);

    todos.value = result;
  }

  Future<void> saveTodo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = TodoModel.encode(todos);
    await prefs.setString('todo_key', encodedData);
  }

  void addTodo(TodoModel todo) {
    todos.add(todo);
    saveTodo();
  }

  void completeTodo(TodoModel todo) {
    int index = todos.indexWhere((element) => element.id == todo.id);
    todos[index] = todo.copyWith(
      isCompleted: true,
    );
    saveTodo();
  }

  void deleteTodo(TodoModel todo) {
    int index = todos.indexWhere((element) => element.id == todo.id);
    todos.removeAt(index);
    saveTodo();
  }

  void editTodo(TodoModel todo, String value) {
    int index = todos.indexWhere((element) => element.id == todo.id);
    todos[index] = todo.copyWith(
      title: value,
    );
    saveTodo();
  }

  void insertTodo(TodoModel todo, int index) {
    todos.insert(index, todo);
    saveTodo();
  }

  void reorderTodo(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = todos.removeAt(oldIndex);
    todos.insert(newIndex, item);
  }
}
