import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course_model.dart';
import 'course_screen.dart';
import '../provider/courses_provider.dart';

const Color mainColor = Colors.blue;

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  void _editCourse(BuildContext context, Course id) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CourseScreen(course: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final courses = coursesProvider.courses;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: Key(courses[index].name),
          child: CourseTile(
            course: courses[index],
            onEdit: () => _editCourse(context, courses[index]),
          ),
        ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final VoidCallback onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average : $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            onTap: onEdit,
            title: Text(course.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(numberText), Text(averageText)],
            ),
          ),
        ),
      ),
    );
  }
}
