// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, avoid_print, implementation_imports

import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:medical_project/Models/drawer.dart';
import 'package:medical_project/animiacovidresult.dart';
import 'package:medical_project/generated/locale_keys.g.dart';
import 'package:medical_project/Models/result.dart';
import 'package:medical_project/routes.dart';
import 'Models/person.dart';
import 'Models/result.dart';
import 'package:http/http.dart' as http;

class AfterResult extends StatefulWidget {
  final http.Client client;
  final Person person;
  var result;
  AfterResult(this.person, {required this.client, required this.result});
  @override
  State<AfterResult> createState() => _AfterResultState();
}

class _AfterResultState extends State<AfterResult> {
  var routes = Routes().getroutes();
  var finalResult;

  callclasifyocr() async {
    Uri ocrClassify = Uri.parse(routes[0]["OCRClassify"]!);
    var req = await widget.client.get(ocrClassify);
    setState(() {});
    print(req.request);
    print(req.body);
    return (req.body);
  }

  callclasifyvalues({
    required hemoglobin,
    required mch,
    required mchc,
    required mcv,
    required wbc,
    required mot,
    required lyt,
  }) async {
    Uri veluesClassify = Uri.parse(routes[0]["EnteredValuesClassify"]);
    var req = await widget.client.post(veluesClassify, body: {
      "hemoglobin": "$hemoglobin",
      "mch": "$mch",
      "mchc": "$mchc",
      "mcv": "$mcv",
      "wbc": "$wbc",
      "mot": "$mot",
      "lyt": "$lyt"
    });
    setState(() {});
    print(req.body);
    return req.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DefaultDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text(
          LocaleKeys.test_result.tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue[300],
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return buildResulItem(widget.person.results[index]);
                },
                itemCount: widget.person.results.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue[300],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50.0,
                child: MaterialButton(
                  onPressed: () async {
                    if (widget.person.isOCRTest) {
                      finalResult = await callclasifyocr();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnimiaCovidResult(
                                  widget.person,
                                  covidanimiaresult: finalResult,
                                )),
                      );
                    } else {
                      finalResult = await callclasifyvalues(
                        hemoglobin: widget.person.results[1].value,
                        mch: widget.person.results[3].value,
                        mchc: widget.person.results[4].value,
                        mcv: widget.person.results[2].value,
                        wbc: widget.person.results[0].value,
                        mot: widget.person.results[6].value,
                        lyt: widget.person.results[5].value,
                      );
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnimiaCovidResult(
                                  widget.person,
                                  covidanimiaresult: finalResult,
                                )),
                      );
                    }
                  },
                  child: Text(
                    LocaleKeys.last_results.tr(),
                    style: TextStyle(
                        fontSize: 20.0,
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
          ),
        ],
      ),
    );
  }
}
