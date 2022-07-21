import 'package:medical_project/Models/result.dart';

class Person {
  String? gender;
  int? age;
  bool isLeukemiaTest = false;
  bool isOCRTest = false;
  bool hasAnimea = false;
  bool hasCovid = false;
  bool hasLukemia = false;
  List<ResultModel> results = [];

  Person({this.gender = "unknown", this.age = 1});
  
}
