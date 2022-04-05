import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/services/user.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class UpdateUser extends StatefulWidget {
  final User user;
  const UpdateUser({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;


  String? name;
  String? email;
  String? password;
  String? type;

   List<Map<String, dynamic>> _users = [
    {
      'value': 'Admin',
      'label': 'Admin',
    },
    {
      'value': 'User',
      'label': 'User',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UPDATE USER'),
          elevation: 0,
        ),
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
              "name",
                widget.user.name.toString(),
              (onValidateVal) {
        

                return null;
              },
              (onSavedVal) => {
                name = onSavedVal,
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
               widget.user.email.toString(),
              (onValidateVal) {
          

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
              multilineRows: 10,
              showPrefixIcon: false,
            ),
          ),
     Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: SelectFormField(
              initialValue: widget.user.type,
              icon: Icon(Icons.category_rounded),
              labelText: 'User Role',
              items: _users,
              onChanged: (val) => print(val),
              onSaved: (val) => {
                type = val,
              },
            ),
          ),

          const SizedBox(
            height: 60,
          ),
         
          Center(
            child: FormHelper.submitButton(
              "UPDATE USER",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                 User user = User(
                     userId: widget.user.userId,
                      name: name == ''
                          ? widget.user.name
                          : name!,
                      email: email == ''
                          ? widget.user.email
                          : email!,
    
                      type: type == ''
                          ? widget.user.type
                          : type!);

                 User.updateUser(user).then(
                    (response) {
                      print("WORK FINE");
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "User",
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





}
