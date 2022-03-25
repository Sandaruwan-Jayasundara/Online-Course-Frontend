import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/services/course.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class Addcourses extends StatefulWidget {
  static String routeName = '/addcourse';
  const Addcourses({ Key? key }) : super(key: key);

  @override
  State<Addcourses> createState() => AddcoursesState();
}

class AddcoursesState extends State<Addcourses> {

  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;

  late final String? courseId;
  late final String? courseName;
  late final String? courseImage;
  late final int? courseDuration;
  late final double? coursePrice;



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
               coursePrice = double.parse(onSavedVal),
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
                  return 'Course Price can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
               courseDuration = int.parse(onSavedVal),
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
                    courseName: courseName,
                    courseDuration:courseDuration,
                    coursePrice:coursePrice
                  );

                  Course.addNewCourse(course).then(
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



  isValidURL(url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}