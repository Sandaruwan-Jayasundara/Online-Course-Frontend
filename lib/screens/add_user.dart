import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/services/course.dart';
import 'package:frontend/services/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class AddUser extends StatefulWidget {
  static String routeName = '/adduser';
  const AddUser({ Key? key }) : super(key: key);

  @override
  State<AddUser> createState() => AddUserState();
}

class AddUserState extends State<AddUser> {

  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;
  bool hidePassword = true;
  late final String? username;
  late final String? email;
  late final String? usertype;
  late final String? password;


  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: userForm(),
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

  Widget userForm() {
    return SingleChildScrollView(

      
      child: Column(

        children: <Widget>[
     
      const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 40, top: 50),
            child: Text(
              "ADD USER",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromARGB(255, 1, 37, 99),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "username",
              "user name",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'user name can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                username = onSavedVal,
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
              "email",
              "email",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'email can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
               email = onSavedVal,
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
              "usertype",
              "usertype",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'usertype can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
               usertype = onSavedVal,
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
              top: 10,),
            child: FormHelper.inputFieldWidget(
              context,
              "Password",
              "Password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Password can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                password = onSavedVal,
              },
              initialValue: "",
              obscureText: hidePassword,
             borderFocusColor: Color.fromARGB(255, 1, 37, 99),
              prefixIconColor: Color.fromARGB(255, 1, 37, 99),
              borderColor: Color.fromARGB(255, 1, 37, 99),
              textColor: Color.fromARGB(255, 1, 37, 99),
              hintColor: Color.fromARGB(255, 1, 37, 99).withOpacity(0.7),
              borderRadius: 10,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
        
        
        const SizedBox(
            height: 60,
          ),
          Center(
            child: FormHelper.submitButton(
              "ADD USER",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });
          
                  User user = User(
                    name: username,
                    email:email,
                    type: usertype,
                    password:password
                  );

                  User.addNewUser(user).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "User",
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
                          "User",
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