import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/services/course.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:image_picker/image_picker.dart';

class Addcourses extends StatefulWidget {
  static String routeName = '/addcourse';
  const Addcourses({Key? key}) : super(key: key);

  @override
  State<Addcourses> createState() => AddcoursesState();
}

class AddcoursesState extends State<Addcourses> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ADD NEW COURSE'),
          elevation: 0,
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
              "courseName",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Course name can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                courseName = onSavedVal,
              },
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
              "coursePrice",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Course Price can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                coursePrice = onSavedVal,
              },
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
              "courseDuration",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Course Duration can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                courseDuration = onSavedVal,
              },
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
          imageprofile(),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: FormHelper.submitButton(
              "ADD COURSE",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  Course course = Course(
                      courseId: "",
                      courseName: courseName!,
                      courseDuration: courseDuration!,
                      courseImage: "",
                      coursePrice: coursePrice!);

                  Course.addNewCourse(course, courseImage!).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Course",
                          "Successfully Added",
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
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
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

  Widget imageprofile() {
    return Center(
      child: Stack(
        children: [
          courseImage != null
              ? Image.file(courseImage!, height: 160, width: 160)
              : FlutterLogo(
                  size: 160,
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
