import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:medical_project/routes.dart';
import 'package:path/path.dart';

class APIHandler {
  var ocrResult;
  var ocrClassifyResult;
  var valuesClassifyResult;
  var leukemiaResult;
  var routes = Routes().getroutes();
  var client = http.Client();

  File? image;

  sendBasicInfo(String gender, String age) async {
    Uri basicInfo = Uri.parse(routes[0]["BasicInfo"]!);
    var res =
        await client.post(basicInfo, body: {"gender": gender, "age": age});
    print("Basic Info Status Code:: ${res.statusCode}");
    print("Basic Info Status Code:: ${res.body}");
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
    var resInitResult = await res.stream.toBytes();
    var resStringResult = String.fromCharCodes(resInitResult);
    var ocrResult = json.decode(resStringResult);
    // var ocrResult = Map<String, dynamic>.from(restoJson);
    Map<String, String> finalresult = {};
    for (int i = 0; i < ocrResult.length; i++) {
      var str = ocrResult.keys.elementAt(i).replaceAll('_', ' ');
      finalresult.addAll({str: ocrResult[ocrResult.keys.elementAt(i)]});
    }
    print(ocrResult);
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
    return analysisResult;
  }
}