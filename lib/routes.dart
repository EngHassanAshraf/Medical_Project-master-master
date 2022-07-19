class Routes {
  getroutes() {
    List<Map<String, String>> routes = [
      {
        "BasicInfo": "http://192.168.1.4:8000/mainmodels/basicinfo/",
        "OCRClassify": "http://192.168.1.4:8000/mainmodels/classifymodels/ocr/",
        "EnteredValuesClassify":
            "http://192.168.1.4:8000/mainmodels/classifymodels/enteredvalues/",
        "CallLeukemia": "http://192.168.1.4:8000/mainmodels/leukemiaclassify/"
      },
      {"OCR": "http://192.168.1.4:8000/ocr/result/"}
    ];
    return routes;
  }
}
