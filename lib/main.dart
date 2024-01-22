import 'package:author_todo/view/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoApp',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        tabBarTheme: const TabBarTheme(
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          labelStyle: TextStyle(
            height: 1.21,
          ),
          unselectedLabelStyle: TextStyle(
            height: 1.21,
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const HomeScreen(),
    );
  }
}
