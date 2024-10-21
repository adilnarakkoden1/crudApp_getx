
import 'package:crud_getx/Controller/home_page_controller.dart';
import 'package:crud_getx/model/student.dart';
import 'package:crud_getx/screens/edit_student.dart';
import 'package:crud_getx/screens/register.dart';
import 'package:crud_getx/screens/view_students.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController studentController = Get.find();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 228, 222),
      appBar: AppBar(
        title: const Text("Student Management"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) => studentController.searchStudent(value),
                decoration: InputDecoration(
                  labelText: 'Search Students',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      itemCount: studentController.filteredStudentList.length,
                      itemBuilder: (context, index) {
                        final StudentModel student =
                            studentController.filteredStudentList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => ViewStudents(
                                    student:
                                        studentController.studentRxList[index],
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/5143151.jpg'),
                                  maxRadius: 30,
                                ),
                                title: Text(student.name ?? ''),
                                subtitle: Text(student.age ?? ''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Get.to(() => EditStudent(
                                              student: student,
                                            ));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => Register()),
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
    );
  }
}




// import 'package:crud_getx/Controller/home_page_controller.dart';
// import 'package:crud_getx/model/student.dart';
// import 'package:crud_getx/screens/edit_student.dart';
// import 'package:crud_getx/screens/register.dart';
// import 'package:crud_getx/screens/view_students.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final StudentController studentController = Get.find();
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 172, 228, 222),
//       appBar: AppBar(
//         title: const Text("Student Management"),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.teal,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Obx(
//                   () => ListView.builder(
//                       itemCount: studentController.studentList.length,
//                       itemBuilder: (context, index) {
//                         final StudentModel student =
//                             studentController.studentList[index];
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.to(() => ViewStudents(
//                                     student:
//                                         studentController.studentRxList[index],
//                                   ));
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                               ),
//                               child: ListTile(
//                                 leading: CircleAvatar(
//                                   backgroundImage:
//                                       AssetImage('assets/5143151.jpg'),
//                                   maxRadius: 30,
//                                 ),
//                                 title: Text(student.name ?? ''),
//                                 subtitle: Text(student.age ?? ''),
//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.edit),
//                                       onPressed: () {
//                                         Get.to(() => EditStudent(
//                                               student: student,
//                                             ));
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Get.to(() => Register()),
//         backgroundColor: Colors.cyan,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
