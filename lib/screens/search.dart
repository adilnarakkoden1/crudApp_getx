// import 'dart:io';
// import 'package:crud_getx/Controller/home_page_controller.dart';
// import 'package:crud_getx/model/student.dart';
// import 'package:crud_getx/screens/view_students.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SearchScreen extends StatelessWidget {
//   SearchScreen({super.key});
//   final searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final StudentController studentController = Get.find();
//     studentController.filteredStudentList.clear();
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 225, 227, 229),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             CupertinoSearchTextField(
//               padding: const EdgeInsets.all(20),
//               controller: searchController,
//               onChanged: (value) =>
//                   studentController.searchStudent(searchController.text),
//             ),
//             Obx(
//               () => studentController.filteredStudentList.isEmpty &&
//                       searchController.text.isNotEmpty
//                   ? Padding(
//                       padding: const EdgeInsets.only(top: 150.0),
//                       child: Image.asset(
//                         '5143151.png',
//                         height: 200,
//                       ),
//                     )
//                   : Expanded(
//                       child: ListView.builder(
//                           itemCount:
//                               studentController.filteredStudentList.length,
//                           itemBuilder: (context, index) {
//                             StudentModel student =
//                                 studentController.filteredStudentList[index];
//                             return InkWell(
//                               onTap: () {
//                                 Get.to(ViewStudents(student: student));
//                               },
                            
//                             );
//                           }),
//                     ),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }
