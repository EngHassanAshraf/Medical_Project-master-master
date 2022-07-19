// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, override_on_non_overriding_member, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_project/Models/person.dart';
import 'package:medical_project/Models/result.dart';
import 'package:medical_project/routes.dart';

import 'after_result.dart';
import 'Models/drawer.dart';
import 'package:medical_project/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class TestValues extends StatefulWidget {
  final Person person;
  http.Client client;
  TestValues(this.person, {required this.client});

  @override
  State<TestValues> createState() => _TestValuesState();
}

class _TestValuesState extends State<TestValues> {
  var formKey = GlobalKey<FormState>();
  List<ResultModel> results = [
    ResultModel(name: 'WBC', translation: 'كرات الدم البيضاء'),
    ResultModel(name: 'HGB', translation: 'الهيموغلوبين'),
    ResultModel(name: 'MCV', translation: 'الحجم الكريوي المتوسط'),
    ResultModel(name: 'MCH', translation: 'متوسط كرات الهيموجلوبين'),
    ResultModel(name: 'MCHC', translation: 'تركيز ھيموغلوبين الكرية'),
    ResultModel(name: 'LYMPH', translation: 'عدد اللمفاويات'),
    ResultModel(name: 'MONO', translation: 'الخلايا الوحيدة'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: DefaultDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Text(
            LocaleKeys.enter_values_text.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) =>
                      ResultItemBuilder(results[index]),
                  itemCount: results.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                    height: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      widget.person.results = results;
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AfterResult(
                                    widget.person,
                                    client: widget.client,
                                    result: '',
                                  )),
                        );
                      }
                    },
                    child: Text(
                      LocaleKeys.next_button.tr(),
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget ResultItemBuilder(ResultModel result) => Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: TextFormField(
              controller: result.controller,
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  result.value = double.parse(value);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return (LocaleKeys.wrong_input.tr());
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: result.name,
                labelStyle: TextStyle(fontSize: 25.0, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
        ),
      );
}
