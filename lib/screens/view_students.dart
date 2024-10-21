import 'dart:io';
import 'package:crud_getx/model/student.dart';
import 'package:crud_getx/screens/edit_student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewStudents extends StatelessWidget {
  final StudentModel student;
  const ViewStudents({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 172, 228, 222),
        appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text(
              'Details of ${student.name}',
              style: TextStyle(fontSize: 15),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
                radius: 100, backgroundImage: FileImage(File(student.image))),
            const SizedBox(
              height: 50,
            ),
            widget('Name', String, student.name),
            const SizedBox(
              height: 20,
            ),
            widget('Age', String, student.age),
            const SizedBox(
              height: 20,
            ),
            widget('Phone', String, student.course),
            const SizedBox(
              height: 20,
            ),
            widget('Place', String, student.place),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                ),
              ],
            )
          ],
        ));
  }

  widget(String name, String, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            children: [
              Text(
                data,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ],
          )
        ],
      ),
    );
  }
}
