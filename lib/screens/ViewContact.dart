import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/services/contact.dart';
import 'package:frontend/services/user.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class ViewContact extends StatefulWidget {
  final Contact contact;
  const ViewContact({Key? key, required this.contact}) : super(key: key);

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;


  String? reply;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('View Message'),
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

           child: const Text('View Message'),
          
          ),
       
           
         const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),

           child: const Text('View Message'),
          
          ),
       
              const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),

           child: const Text('View Message'),
          
          ),
       


          const SizedBox(
            height: 20,
          ),


          FormHelper.inputFieldWidget(
              context,
              "reply",
              "reply",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Reply can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                reply = onSavedVal,
              },
              isMultiline: true,
              initialValue: "",
              obscureText: false,
              borderFocusColor: Colors.blue,
              prefixIconColor: Colors.blue,
              borderColor: Colors.blue,
              textColor: Colors.blue,
              hintColor: Colors.blue.withOpacity(0.7),
              borderRadius: 10,
            ),




          const SizedBox(
            height: 60,
          ),
         
          Center(
            child: FormHelper.submitButton(
              "Reply",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                 Contact contact = Contact(
                      reply: reply,
                     contactId: widget.contact.contactId,
                     );

                 Contact.Reply(contact).then(
                    (response) {
                      print("WORK FINE");
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Message",
                          "Replied",
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
                          "Message",
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
