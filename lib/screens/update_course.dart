import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:image_picker/image_picker.dart';

import '../services/category.dart';
import '../services/course.dart';

class UpdateCourse extends StatefulWidget {
  final Course course;
  const UpdateCourse({Key? key, required this.course}) : super(key: key);

  @override
  State<UpdateCourse> createState() => _UpdateCourseState();
}

class _UpdateCourseState extends State<UpdateCourse> {
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;
  File? courseImage;

  String? courseId;
  String? courseName;
  String? courseDuration;
  String? coursePrice;
  String? courseCategory;
  String? courseDescription;
  String? imagePath;

  List<Map<String, dynamic>> _categories = [
    {'value': 'Information Technology', 'label': 'InformationTechnology'},
    {
      'value': 'Languages',
      'label': 'Languages',
    },
    {
      'value': 'Mathematics',
      'label': 'Mathematics',
    },
  ];

  List<Map<String, dynamic>> _data = [];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    List<Category> list = await Category.getAllCategories();
    Future.wait(list.map((item) async => {
          _data.add({
            'value': item.CategoryName,
            'label': item.CategoryName,
          })
        }));

    setState(() {
      _categories = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child:
                Text('Update Course', style: GoogleFonts.oswald(fontSize: 25)),
          ),
          elevation: 0,
          backgroundColor: Colors.orange,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: courseForm(),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget courseForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "courseName",
              "course Name",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Course name can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                courseName = onSavedVal,
              },
              initialValue: widget.course.courseName,
              obscureText: false,
              borderFocusColor: Color.fromARGB(255, 1, 37, 99),
              prefixIconColor: Color.fromARGB(255, 1, 37, 99),
              borderColor: Color.fromARGB(255, 1, 37, 99),
              textColor: Color.fromARGB(255, 1, 37, 99),
              hintColor: Color.fromARGB(255, 1, 37, 99).withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "coursePrice",
              "Course Price",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Course Price can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                coursePrice = onSavedVal,
              },
              initialValue: widget.course.coursePrice,
              obscureText: false,
              borderFocusColor: Color.fromARGB(255, 1, 37, 99),
              prefixIconColor: Color.fromARGB(255, 1, 37, 99),
              borderColor: Color.fromARGB(255, 1, 37, 99),
              textColor: Color.fromARGB(255, 1, 37, 99),
              hintColor: Color.fromARGB(255, 1, 37, 99).withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.monetization_on),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "courseDuration",
              "Course Duration",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Course Duration can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                courseDuration = onSavedVal,
              },
              initialValue: widget.course.courseDuration,
              obscureText: false,
              borderFocusColor: Color.fromARGB(255, 1, 37, 99),
              prefixIconColor: Color.fromARGB(255, 1, 37, 99),
              borderColor: Color.fromARGB(255, 1, 37, 99),
              textColor: Color.fromARGB(255, 1, 37, 99),
              hintColor: Color.fromARGB(255, 1, 37, 99).withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: SelectFormField(
              initialValue: widget.course.courseCategory,
              icon: Icon(Icons.category_rounded),
              labelText: 'Course Category',
              items: _categories,
              onChanged: (val) => print(val),
              onSaved: (val) => {
                courseCategory = val,
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "courseDescription",
              "Course Description",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Course Description cant be null!.';
                }

                return null;
              },
              (onSavedVal) => {
                courseDescription = onSavedVal,
              },
              initialValue: widget.course.courseDescription,
              obscureText: false,
              borderFocusColor: Color.fromARGB(255, 1, 37, 99),
              prefixIconColor: Color.fromARGB(255, 1, 37, 99),
              borderColor: Color.fromARGB(255, 1, 37, 99),
              textColor: Color.fromARGB(255, 1, 37, 99),
              hintColor: Color.fromARGB(255, 1, 37, 99).withOpacity(0.7),
              borderRadius: 10,
              multilineRows: 10,
              showPrefixIcon: false,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          imageprofile(),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: FormHelper.submitButton(
              "Update Course",
      
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  Course course = Course(
                      courseId: widget.course.courseId,
                      courseName: courseName!,
                      courseDuration: courseDuration!,
                      courseImage: widget.course.courseImage,
                      coursePrice: coursePrice!,
                      courseCategory: courseCategory!,
                      courseDescription: courseDescription!);

                  (courseImage == null
                          ? Course.updateCourseWithoutImage(course)
                          : Course.updateCourse(course, courseImage!))
                      .then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Course",
                          "Successfully Updated",
                          "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                              (route) => false,
                            );
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Course",
                          "Process failed",
                          "OK",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: Colors.orange,
              borderColor: Colors.black,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void setDefault() {
    setState(() {
      courseDescription = ' ';
    });
  }

  Widget imageprofile() {
    return Center(
      child: Stack(
        children: [
          courseImage != null
              ? Image.file(courseImage!, height: 160, width: 160)
              : Image.asset(
                  widget.course.courseImage,
                  height: 160,
                  width: 160,
                ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));
                },
                child: Icon(Icons.camera_alt, color: Colors.black, size: 28.0)),
          )
        ],
      ),
    );
  }

  Future takePhoto(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.courseImage = imageTemporary;
    });
  }

  Widget bottomSheet() {
    return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(
              "choose a photo",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      takePhoto(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera),
                    label: Text("camera")),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      takePhoto(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                    label: Text("gallery")),
              ],
            ),
          ],
        ));
  }

  isValidURL(url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}
