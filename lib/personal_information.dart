// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:medical_project/Models/person.dart';
import 'package:medical_project/routes.dart';
import 'package:medical_project/select_photo.dart';
import 'package:medical_project/test_values.dart';
import 'Models/drawer.dart';
import './generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class PersonalInformation extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<PersonalInformation> {
  bool isMale = true;
  int age = 20;
  Person person = Person();
  http.Client client = http.Client();
  List<Map<String, String>> routes = Routes().getroutes();
  //
  // Send Basic Info
  //
  sendBasicInfo(String gender, String age) async {
    Uri basicInfo = Uri.parse(routes[0]["BasicInfo"]!);
    print("fuuffunfufnfu $basicInfo");
    var res =
        await client.post(basicInfo, body: {"gender": gender, "age": age});
    print("fuuffunfufnfu wait");
    print("Basic Info Status Code:: ${res.statusCode}");
    print("Basic Info Status Code:: ${res.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DefaultDrawer(),
      appBar: AppBar(
        title: Text(
          LocaleKeys.personal_information_text.tr(),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/images/male.png'),
                                height: 90.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                LocaleKeys.male_text.tr(),
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: isMale ? Colors.blue : Colors.grey[400],
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
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/images/female.png'),
                                height: 90.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                LocaleKeys.female_text.tr(),
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: !isMale ? Colors.blue : Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.age_text.tr(),
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          age.toString(),
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                              mini: true,
                              child: Icon(
                                Icons.remove,
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              mini: true,
                              child: Icon(
                                Icons.add,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50.0,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    person.age = age;
                    isMale ? person.gender = "Male" : person.gender = "Female";
                    person.isLeukemiaTest = false;
                    person.isOCRTest = true;
                    sendBasicInfo((person.gender!).toString().toLowerCase(),
                        (person.age).toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChoosePhoto(person),
                      ),
                    );
                  },
                  child: Text(
                    LocaleKeys.cbc_text.tr(),
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
            // Leukemia
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Container(
                height: 50.0,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    person.age = age;
                    isMale ? person.gender = "Male" : person.gender = "Female";
                    person.isLeukemiaTest = true;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChoosePhoto(person),
                      ),
                    );
                    setState(() {
                      person.isLeukemiaTest = true;
                    });
                  },
                  child: Text(
                    LocaleKeys.leukemia_text.tr(),
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
            // translation
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50.0,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    person.age = age;
                    isMale ? person.gender = "Male" : person.gender = "Female";
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChoosePhoto(person),
                        ));
                  },
                  child: Text(
                    LocaleKeys.translation_only_text.tr(),
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
            // EnteredValues
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Container(
                height: 50.0,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    print("seeeendndnendnednend1111");
                    person.age = age;
                    isMale ? person.gender = "Male" : person.gender = "Female";
                    person.isLeukemiaTest = false;
                    print("seeeendndnendnednend2222");
                    sendBasicInfo((person.gender!).toString().toLowerCase(),
                        (person.age).toString());
                    print("seeeendndnendnednend33333");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestValues(
                          person,
                          client: client,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    LocaleKeys.enter_values_text.tr(),
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
      ),
    );
  }
}
