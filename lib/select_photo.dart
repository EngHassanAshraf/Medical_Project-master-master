// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, override_on_non_overriding_member, annotate_overrides, await_only_futures, unused_local_variable, unused_catch_clause, avoid_print, unnecessary_this, implementation_imports

import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_project/Models/person.dart';
import 'package:medical_project/after_result.dart';
import 'dart:io';

import 'package:medical_project/Models/drawer.dart';
import 'package:medical_project/apiHandler.dart';
import 'package:medical_project/generated/locale_keys.g.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:medical_project/leukemiaresult.dart';
import 'package:medical_project/routes.dart';
import 'package:path/path.dart';

class ChoosePhoto extends StatefulWidget {
  http.Client client = http.Client();
  Person person;
  ChoosePhoto(this.person, {Key? key}) : super(key: key);
  @override
  State<ChoosePhoto> createState() => _ChoosePhotoState();
}

class _ChoosePhotoState extends State<ChoosePhoto> {
  File? image;
  Map<String, String> ocrResult = {};
  Map<String, dynamic> leukemiaResult = {};

  var clientResult = '';

  var routes = Routes().getroutes();

  // List<ResultModel> results = [
  //   ResultModel(name: 'WBC', translation: 'كرات الدم البيضاء'),
  //   ResultModel(name: 'HGB', translation: 'الهيموغلوبين'),
  //   ResultModel(name: 'MCV', translation: 'الحجم الكريوي المتوسط'),
  //   ResultModel(name: 'MCH', translation: 'متوسط كرات الهيموجلوبين'),
  //   ResultModel(name: 'MCHC', translation: 'تركيز ھيموغلوبين الكرية'),
  //   ResultModel(name: 'LYMPH', translation: 'عدد اللمفاويات'),
  //   ResultModel(name: 'MONO', translation: 'الخلايا الوحيدة'),
  // ];

  Future pickImage({required ImageSource source}) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick an image: $e');
    }
  }

  Future<Map<String, String>> getOCRresult() async {
    var request = http.MultipartRequest('POST', Uri.parse(routes[1]["OCR"]));

    if (image == null) return {"": ""};
    var pickimg = http.MultipartFile.fromPath(
      'image',
      image!.path,
      filename: basename(image!.path),
      contentType: MediaType.parse('multipart/form-data'),
    );

    request.files.add(await pickimg);
    print("Request::: $request,\n");
    var res = await request.send();

    var vr = json.decode(String.fromCharCodes(await res.stream.toBytes()));
    Map<String, String> finalresult = {};
    for (int i = 0; i < vr.length; i++) {
      var str = vr.keys.elementAt(i).replaceAll('_', ' ');
      finalresult.addAll({str: vr[vr.keys.elementAt(i)]});
    }
    print(vr);
    setState(() {});
    return finalresult;
  }

  Future<Map<String, dynamic>> getLeukemiaResult() async {
    var request =
        http.MultipartRequest('POST', Uri.parse(routes[0]["CallLeukemia"]));

    if (image == null) return {"": ""};
    var pickimg = http.MultipartFile.fromPath(
      'image',
      image!.path,
      filename: basename(image!.path),
      contentType: MediaType.parse('multipart/form-data'),
    );

    request.files.add(await pickimg);
    print("Request::: $request,\n");
    var res = await request.send();

    var analysisResult = Map<String, dynamic>.from(
        json.decode(String.fromCharCodes(await res.stream.toBytes())));

    print(analysisResult);
    setState(() {});
    return analysisResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DefaultDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text(
          LocaleKeys.Select_photo.tr(),
          style: TextStyle(
            // fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                height: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    var fromcamera = false;
                    pickImage(source: ImageSource.gallery);
                  },
                  child: Text(
                    LocaleKeys.gallery.tr(),
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 50.0,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    pickImage(source: ImageSource.camera);
                  },
                  child: Text(
                    LocaleKeys.open_camera.tr(),
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue[800],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: image != null
                        ? Image.file(image!)
                        : Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 100.0,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  LocaleKeys.no_image.tr(),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.black26),
                          ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          widget.person.isLeukemiaTest = false;
                          widget.person.isOCRTest = false;
                          Navigator.pop(context);
                        },
                        child: Text(
                          LocaleKeys.previous.tr(),
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
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () async {
                          if (image == null) {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text(LocaleKeys.warning.tr()),
                                content: Text(LocaleKeys.have_choose.tr()),
                                actions: <Widget>[
                                  Center(
                                    child: TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(LocaleKeys.ok.tr()),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            if (!(widget.person.isLeukemiaTest)) {
                              ocrResult = await getOCRresult();
                              print(ocrResult);
                              widget.person = await APIHandler()
                                  .insertValuesFunction(
                                      person: widget.person,
                                      finalResult: ocrResult,
                                      dictList: widget.person.dictionarylist);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AfterResult(
                                      widget.person,
                                      client: widget.client,
                                      result: ocrResult),
                                ),
                              );
                            } else {
                              print(widget.person.isLeukemiaTest);
                              print(widget.person.isOCRTest);
                              leukemiaResult = await getLeukemiaResult();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LeukemiaResult(
                                      widget.person,
                                      result: leukemiaResult),
                                ),
                              );
                            }
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
            ],
          ),
        ),
      ),
    );
  }
}
