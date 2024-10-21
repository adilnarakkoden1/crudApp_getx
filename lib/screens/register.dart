import 'dart:io';

import 'package:crud_getx/Controller/home_page_controller.dart';
import 'package:crud_getx/model/student.dart';
import 'package:crud_getx/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();
  final courseController = TextEditingController();
  final StudentController studentController = Get.put(StudentController());
  final PickedImageController pickedImageController =
      Get.put(PickedImageController());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 228, 222),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text('Student Registration'),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => pickImage(pickedImageController),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: pickedImageController.selectedImage.value !=
                                    null
                                ? ClipOval(
                                    child: Image.file(
                                      pickedImageController
                                          .selectedImage.value!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(Icons.add_photo_alternate,
                                    size: 40,
                                    color: Color.fromARGB(255, 20, 17, 8)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextBox(
                        controller: nameController,
                        labelText: 'Name',
                        keyboardtype: TextInputType.name,
                        suffixIcon: Icon(Icons.person),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter name';
                          }
                          if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                            return 'No special characters or numbers allowed';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextBox(
                        controller: ageController,
                        labelText: 'Age',
                        keyboardtype: TextInputType.number,
                        suffixIcon: Icon(Icons.abc),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter age';
                          }
                          if (!RegExp(r'^\d{1,2}$').hasMatch(value)) {
                            return 'Please enter a valid age';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextBox(
                        controller: placeController,
                        keyboardtype: TextInputType.name,
                        labelText: 'Place',
                        suffixIcon: Icon(Icons.location_on),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number';
                          } else if (value.length != 10) {
                            return 'Please enter a 10-digit number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextBox(
                        controller: courseController,
                        keyboardtype: TextInputType.name,
                        labelText: 'Course',
                        suffixIcon: Icon(Icons.book),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter course';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            saveStudent();
                            Get.snackbar('Successfully added Student', '');
                          } else {
                            // Form is invalid
                            Get.snackbar('Please check credentials', '',
                                colorText: Colors.red);
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Future<void> addStudent(StudentModel student) async {
    final studentBox = await Hive.openBox<StudentModel>('student');
    await studentBox.add(student);
  }

  void saveStudent() async {
    if (_formkey.currentState!.validate()) {
      StudentModel student = StudentModel();
      student.name = nameController.text.trim();
      student.age = ageController.text.trim();
      student.place = placeController.text.trim();
      student.course = courseController.text.trim();
      student.image = pickedImageController.selectedImage.value?.path ?? '';

      await studentController.addStudent(student);
    }
  }

  void pickImage(PickedImageController controller) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        controller.selectedImage.value = File(pickedImage.path);
      }
    } catch (e) {
      // Handle the error here if necessary
    }
  }
}

class PickedImageController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
}
