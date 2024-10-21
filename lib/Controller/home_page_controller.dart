import 'package:crud_getx/model/student.dart';
import 'package:crud_getx/screens/home.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StudentController extends GetxController {
  RxList<StudentModel> studentRxList = <StudentModel>[].obs;
  final RxList<StudentModel> filteredStudentList = <StudentModel>[].obs;
  late Box<StudentModel> studentBox;

  @override
  void onInit() {
    super.onInit();
    _openBox();
  }

  Future<void> _openBox() async {
    studentBox = await Hive.openBox<StudentModel>('student');
    loadStudents();
  }

  List<StudentModel> get studentList => studentRxList.toList();

  Future<void> loadStudents() async {
    studentRxList.assignAll(studentBox.values.toList().cast<StudentModel>());
    studentBox.watch().listen((event) {
      studentRxList.assignAll(studentBox.values.toList().cast<StudentModel>());
      updateFilteredStudentList();
    });
    updateFilteredStudentList(); // Ensure the filtered list is updated after loading students
  }

  Future<void> addStudent(StudentModel student) async {
    try {
      await studentBox.add(student);
      studentRxList.add(student);
      updateFilteredStudentList(); // Ensure the filtered list is updated after adding a student
      Get.snackbar(
        'Success',
        'Student added successfully',
      );
      Get.offAll(const HomePage());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add student: $e',
      );
    }
  }

  void searchStudent(String query) {
    if (query.isEmpty) {
      updateFilteredStudentList(); // Show all students when query is empty
    } else {
      filteredStudentList.value = studentList.where((student) {
        return student.name?.toLowerCase().contains(query.toLowerCase()) ??
            false;
      }).toList();
    }
  }

  void updateFilteredStudentList() {
    filteredStudentList.value = studentList;
  }
}




// import 'package:crud_getx/model/student.dart';
// import 'package:crud_getx/screens/home.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';

// class StudentController extends GetxController {
//   RxList<StudentModel> studentRxList = <StudentModel>[].obs;
//   final RxList<StudentModel> filteredStudentList = <StudentModel>[].obs;
//   late Box<StudentModel> studentBox;

//   @override
//   void onInit() {
//     super.onInit();
//     _openBox();

//     filteredStudentList.value = studentList;
//   }

//   Future<void> _openBox() async {
//     studentBox = await Hive.openBox<StudentModel>('student');
//     loadStudents();
//   }

//   List<StudentModel> get studentList => studentRxList.toList();

//   Future<void> loadStudents() async {
//     studentRxList.assignAll(studentBox.values.toList().cast<StudentModel>());
//     studentBox.watch().listen((event) => studentRxList
//         .assignAll(studentBox.values.toList().cast<StudentModel>()));
//   }

//   Future<void> addStudent(StudentModel student) async {
//     try {
//       await studentBox.add(student);
//       studentRxList.add(student);
//       Get.snackbar(
//         'Success',
//         'Student added successfully',
//       );
//       Get.offAll(const HomePage());
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to add student: $e',
//       );
//     }
//   }

//   void searchStudent(String query) {
//     if (query.isEmpty) {
//       filteredStudentList.value =
//           studentList; // Show all students when query is empty
//     } else {
//       filteredStudentList.value = studentList.where((student) {
//         return student.name?.toLowerCase().contains(query.toLowerCase()) ??
//             false;
//       }).toList();
//     }
//   }
// }