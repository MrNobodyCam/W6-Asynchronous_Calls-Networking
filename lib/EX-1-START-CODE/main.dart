import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/courses_provider.dart';
import 'screens/course_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CoursesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseListScreen(),
    );
  }
}
