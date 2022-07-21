class Routes {
  var host = "192.168.24.37";
  getroutes() {
    List<Map<String, String>> routes = [
      {
        "BasicInfo": "http://${host}:8000/mainmodels/basicinfo/",
        "OCRClassify": "http://${host}:8000/mainmodels/classifymodels/ocr/",
        "EnteredValuesClassify":
            "http://${host}:8000/mainmodels/classifymodels/enteredvalues/",
        "CallLeukemia": "http://${host}:8000/mainmodels/leukemiaclassify/"
      },
      {"OCR": "http://${host}:8000/ocr/result/"}
    ];
    return routes;
  }
}
