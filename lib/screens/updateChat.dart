import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/services/contact.dart';
import 'package:frontend/services/user.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class UpdateChat extends StatefulWidget {
  final Contact contact;
  const UpdateChat({Key? key, required this.contact}) : super(key: key);

  @override
  State<UpdateChat> createState() => _UpdateChatState();
}

class _UpdateChatState extends State<UpdateChat> {
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;


  String? message;
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Chat'),
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
              "email",
                widget.contact.email.toString(),
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
              showPrefixIcon: false,
            ),
          ),
       
          
         FormHelper.inputFieldWidget(
              context,
              "message",
               widget.contact.message.toString(),
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Message can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                message = onSavedVal,
              },
              isMultiline: true,
              initialValue: "",
              obscureText: false,
                 borderFocusColor: Colors.orange,
              prefixIconColor: Colors.orange,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
            ),









          const SizedBox(
            height: 60,
          ),
         
          Center(
            child: FormHelper.submitButton(
              "Edit Chat",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                 Contact contact = Contact(
                     contactId: widget.contact.contactId,
                      email: email == ''
                          ? widget.contact.email
                          : email!,
                      message: message == ''
                          ? widget.contact.message
                          : message!
                          );

                 Contact.updateContact(contact).then(
                    (response) {
                      print("WORK FINE");
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "My Chat",
                          "Successfully Updated",
                          "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/display-chat',
                              (route) => false,
                            );
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "My Chat",
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
