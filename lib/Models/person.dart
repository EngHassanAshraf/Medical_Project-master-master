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

  List<Dictionary> dictionarylist = [
    //cbc تحليل الدم

    Dictionary(name: 'WBC', translation: 'كرات الدم البيضاء'),
    Dictionary(name: 'White blood Count', translation: 'كرات الدم البيضاء'),
    Dictionary(name: 'White Cell Count', translation: 'كرات الدم البيضاء'),
    Dictionary(name: 'HGB', translation: 'الهيموغلوبين'),
    Dictionary(name: 'Hemoglobin', translation: 'الهيموغلوبين'),
    Dictionary(name: 'MCV', translation: 'الحجم الكريوي المتوسط'),
    Dictionary(name: 'MCH', translation: 'متوسط كرات الهيموجلوبين'),
    Dictionary(name: 'MCHC', translation: 'تركيز ھيموغلوبين الكرية'),
    Dictionary(name: 'Lymphocytes', translation: 'عدد اللمفاويات'),
    Dictionary(name: 'Monocytes', translation: 'الخلايا الوحيدة'),

    //Diabetic Profile تحليل السكر في الدم
    Dictionary(
        name: 'Random Blood Glucose',
        translation: 'نسبة الجلوكوز في الدم العشوائي'),
    //Hepatitis Markers علامات التهاب الكبد
    Dictionary(
        name: 'Hepatitis B - Surface Antigen',
        translation: 'فيروس B الكبدي السطحي'),
    Dictionary(
        name: 'HCV Ab by Chemiluminescent technology ',
        translation: 'فيروس C الكبدى - الكيميائى'),
    //Urine Analysis تحليل البول
    Dictionary(name: 'Color', translation: 'اللون'),
    Dictionary(name: 'Aspect', translation: 'الجانب'),
    Dictionary(name: 'Volume', translation: 'الحجم'),
    Dictionary(name: 'Reaction', translation: 'رد الفعل'),
    Dictionary(
        name: 'Specific Gravity in urine',
        translation: 'الثقل النوعي في البول'),
    Dictionary(name: 'Nitrite', translation: 'نتري'),
    Dictionary(name: "Albumin", translation: 'الزلال'),
    Dictionary(name: 'Sugar', translation: 'السكر'),
    Dictionary(name: 'Acetone', translation: 'أسيتون'),
    Dictionary(name: 'Bile Salts', translation: 'أملاح الصفراء'),
    Dictionary(name: 'Bile Pigments', translation: 'أصباغ الصفراء'),
    Dictionary(name: 'Urobilinogen', translation: 'أوروبيلينوجين'),
    Dictionary(name: 'Leukocyte esterase', translation: 'الكريات البيض إستراز'),
    Dictionary(name: 'RBCs', translation: 'كرات الدم الحمراء'),
    Dictionary(name: 'Pus Cells', translation: 'خلايا القيح'),
    Dictionary(name: 'Epithelial Cells', translation: 'الخلايا الظهارية'),
    Dictionary(name: 'Casts', translation: 'تغشيات'),
    Dictionary(name: 'Ova', translation: 'Ova البويضات'),
    Dictionary(name: 'Crystals', translation: 'البلورات'),
    Dictionary(name: 'Mucus', translation: 'مخاط'),
    Dictionary(name: 'Yeast Cells', translation: 'خلايا الخميرة'),
    Dictionary(name: 'Trichomonas vaginalis', translation: 'المشعرات المهبلية'),
    // Serodiagnosis التشخيص المصلي
    Dictionary(
        name: 'CRP “C-reactive protein”', translation: 'C البروتين التفاعل'),
    //Kidney function tests تحليل وظائف كُلي
    Dictionary(name: 'Serum Creatinine', translation: 'مصل الكرياتينين'),
    Dictionary(name: 'Serum Urea', translation: 'مصل اليوريا'),
    Dictionary(name: 'Serum Calcium', translation: 'مصل الكالسيوم'),
    Dictionary(name: 'Serum Potassium', translation: 'مصل البوتاسيوم'),
    Dictionary(name: 'Serum Sodium', translation: 'مصل الصوديم'),
  ];

  Person({this.gender = "unknown", this.age = 1});
}

class Dictionary {
  String name;
  String translation;
  Dictionary({required this.name, required this.translation});
}
