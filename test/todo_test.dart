import 'package:author_todo/controller/todo_controller.dart';
import 'package:author_todo/model/todo_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final controller = TodoController();
  group('Todo', () {
    test('ongoingTodos의 초기값이 빈 배열인가?', () {
      expect(controller.ongoingTodos, []);
    });
    test('completedTodos의 초기값이 빈 배열인가?', () {
      expect(controller.completedTodos, []);
    });
    test('진행 중인 배열에 값이 잘 들어가는가?', () {
      controller.addTodo(
        TodoModel(
          id: "0",
          title: "코딩 공부하기",
        ),
      );
      controller.addTodo(
        TodoModel(
          id: "1",
          title: "운동하기",
        ),
      );
      expect(controller.ongoingTodos[0].id, "0");
      expect(controller.ongoingTodos[0].title, "코딩 공부하기");
      expect(controller.ongoingTodos[1].id, "1");
      expect(controller.ongoingTodos[1].title, "운동하기");
    });
    test('진행 중인 배열의 값이 잘 수정되는가?', () {
      controller.editTodo(
          TodoModel(
            id: "0",
            title: "코딩 공부하기",
          ),
          "영화 보기");
      expect(controller.ongoingTodos[0].id, "0");
      expect(controller.ongoingTodos[0].title, "영화 보기");
    });
    test('진행 중인 배열의 값의 순서가 잘 교체되는가?', () {
      controller.reorderTodo(controller.ongoingTodos, 1, 0);
      expect(controller.ongoingTodos[0].id, "1");
      expect(controller.ongoingTodos[0].title, "운동하기");
      expect(controller.ongoingTodos[1].id, "0");
      expect(controller.ongoingTodos[1].title, "영화 보기");
    });
    test('진행 중인 배열의 값이 잘 완료되는가?', () {
      controller.completeTodo(
        TodoModel(
          id: "0",
          title: "영화 보기",
        ),
      );
      expect(controller.ongoingTodos[0].id, "1");
      expect(controller.ongoingTodos[0].title, "운동하기");
      expect(controller.completedTodos[0].id, "0");
      expect(controller.completedTodos[0].title, "영화 보기");
    });
    test('배열의 값들이 재실행 이후에도 유지되는가?', () {
      controller.saveTodo();
      controller.getTodo();
      expect(controller.ongoingTodos[0].id, "1");
      expect(controller.ongoingTodos[0].title, "운동하기");
      expect(controller.completedTodos[0].id, "0");
      expect(controller.completedTodos[0].title, "영화 보기");
    });
    test('배열의 값들이 잘 삭제되는가?', () {
      controller.deleteTodo(
        controller.ongoingTodos,
        TodoModel(
          id: "1",
          title: "운동하기",
        ),
      );
      controller.deleteTodo(
        controller.completedTodos,
        TodoModel(
          id: "0",
          title: "영화 보기",
        ),
      );
      expect(controller.ongoingTodos, []);
      expect(controller.completedTodos, []);
    });
  });
}
