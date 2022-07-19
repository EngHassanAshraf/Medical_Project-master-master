// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, prefer_final_fields, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:medical_project/Models/drawer.dart';

class QuestionModel {
  String question;
  String? answer;
  String option1;
  String option2;
  bool isoption1 = false;
  QuestionModel({
    required this.question,
    required this.option1,
    required this.option2,
  });
}

class FeverQuestions extends StatefulWidget {
  @override
  State<FeverQuestions> createState() => _FeverQuestionsState();
}

class _FeverQuestionsState extends State<FeverQuestions> {
  bool isyes = false;
  List<QuestionModel> questions = [
    QuestionModel(
        question: 'What is your gender ?', option1: 'male', option2: 'female'),
    QuestionModel(question: 'Are you ok ?', option1: 'Yes', option2: 'no'),
    QuestionModel(
        question: 'What is your gender ?', option1: 'male', option2: 'female'),
    QuestionModel(question: 'Are you ok ?', option1: 'Yes', option2: 'no'),
    QuestionModel(
        question: 'What is your gender ?', option1: 'male', option2: 'female'),
    QuestionModel(question: 'Are you ok ?', option1: 'Yes', option2: 'no'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DefaultDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text('Fever'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) => Quistionbuilditem(() {
          setState(() {
            questions[index].isoption1 = true;
            questions[index].answer = questions[index].option1;
          });
        }, () {
          setState(() {
            questions[index].isoption1 = false;
            questions[index].answer = questions[index].option2;
          });
        }, questions[index]),
        itemCount: questions.length,
        separatorBuilder: (BuildContext context, int index) => Container(
          height: 1.0,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}

Widget Quistionbuilditem(
        Function ontap_1, Function ontap_2, QuestionModel question) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment
                .start, // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                question.question,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ontap_1();
                        },
                        child: Container(
                          color:
                              question.isoption1 ? Colors.green : Colors.blue,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              question.option1,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ontap_2();
                        },
                        child: Container(
                          color: question.isoption1 ? Colors.blue : Colors.red,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              question.option2,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blue[100],
        ),
      ),
    );
