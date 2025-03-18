import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/courses_provider.dart';
import 'screens/course_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CoursesProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CourseListScreen(),
      ),
    );
  }
}
