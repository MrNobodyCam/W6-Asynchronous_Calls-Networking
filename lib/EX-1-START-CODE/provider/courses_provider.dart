import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../repository/course_mock_repository.dart';

class CoursesProvider with ChangeNotifier {
  final List<Course> _courses = MockCoursesRepository().getCourses();

  List<Course> get courses => _courses;

  Course getCourseFor(String courseID) {
    return _courses.firstWhere((course) => course.name == courseID);
  }

  void addScore(String courseID, CourseScore score) {
    final course = getCourseFor(courseID);
    course.addScore(score);
    notifyListeners();
  }
}
