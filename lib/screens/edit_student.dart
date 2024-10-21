import 'package:crud_getx/Controller/home_page_controller.dart';
import 'package:crud_getx/model/student.dart';
import 'package:crud_getx/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditStudent extends StatelessWidget {
  final StudentModel student;
  EditStudent({super.key, required this.student});
  final StudentController studentController = Get.find<StudentController>();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: student.name);
    final TextEditingController ageController =
        TextEditingController(text: student.age);
    final TextEditingController placeController =
        TextEditingController(text: student.place);
    final TextEditingController courseController =
        TextEditingController(text: student.course);
    final PickedImageEditController pickedImageEditController =
        Get.put(PickedImageEditController());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 228, 222),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Edit Student'),
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
                        onTap: () => pickImage(pickedImageEditController),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 140, top: 15),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child:
                                pickedImageEditController.selectedImage.value !=
                                        null
                                    ? ClipOval(
                                        child: Image.file(
                                          pickedImageEditController
                                              .selectedImage.value!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.add_photo_alternate,
                                        size: 60,
                                        color: Colors.white,
                                      ),
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
                          if (value!.isEmpty) {
                            return 'Please enter place';
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
                            // Form is valid, proceed with further actions
                            Get.snackbar('Successfully Edited Student', '');
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

  void pickImage(PickedImageEditController controller) async {
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

class PickedImageEditController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
}
