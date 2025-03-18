import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course_model.dart';
import 'course_score_form.dart';
import '../provider/courses_provider.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.course});

  final Course course;

  void _addScore(BuildContext context) async {
    CourseScore? newScore = await Navigator.of(context).push<CourseScore>(
      MaterialPageRoute(builder: (ctx) => const CourseScoreForm()),
    );

    if (newScore != null) {
      Provider.of<CoursesProvider>(context, listen: false)
          .addScore(course.name, newScore);
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Consumer<CoursesProvider>(
      builder: (context, coursesProvider, child) {
        final scores = coursesProvider.getCourseFor(course.name).scores;
        if (scores.isEmpty) {
          return const Center(child: Text('No Scores added yet.'));
        }
        return ListView.builder(
          itemCount: scores.length,
          itemBuilder: (ctx, index) => ListTile(
            title: Text(scores[index].studentName),
            trailing: Text(
              scores[index].studenScore.toString(),
              style: TextStyle(
                color: scoreColor(scores[index].studenScore),
                fontSize: 15,
              ),
            ),
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: mainColor,
        title: Text(
          course.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () => _addScore(context), icon: const Icon(Icons.add)),
        ],
      ),
      body: content,
    );
  }
}
