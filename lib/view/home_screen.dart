import 'package:author_todo/controller/todo_controller.dart';
import 'package:author_todo/view/widgets/common_tab.dart';
import 'package:author_todo/view/widgets/completed_page.dart';
import 'package:author_todo/view/widgets/ongoing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TodoController todoController = Get.put(TodoController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    todoController.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          labelPadding: const EdgeInsets.all(5),
          indicatorPadding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          tabs: const [
            CommonTab(
              title: "진행 중",
            ),
            CommonTab(
              title: "완료",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Obx(() {
            var todos = todoController.todos
                .where((t) => t.isCompleted == false)
                .toList();
            return OngoingPage(todos: todos);
          }),
          Obx(() {
            var todos = todoController.todos
                .where((t) => t.isCompleted == true)
                .toList();
            return CompletedPage(
              todos: todos,
            );
          }),
        ],
      ),
    );
  }
}
