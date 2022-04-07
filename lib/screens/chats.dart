import 'package:flutter/material.dart';
import 'package:frontend/services/contact.dart';
import 'package:frontend/theme/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Chats extends StatefulWidget {
  const Chats({ Key? key }) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  bool isApiCallProcess = false;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? message;
 

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
             appBar: AppBar(
                       backgroundColor: Colors.orange,
              title: Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  "Contact",
                  style: GoogleFonts.oswald(fontSize: 25),
                ),
              )),
        ),
        
      ),
    
        body: ProgressHUD(
          
          child: Form(
            key: globalFormKey,
            child: _chatsUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }
  getHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Account",
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
  Widget _chatsUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: const BoxDecoration(
             
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
           
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "email",
              "Email",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Email can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                email = onSavedVal,
              },
              initialValue: "",
              obscureText: false,
              borderFocusColor: Colors.orange,
              prefixIconColor: Colors.orange,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),



          const SizedBox(
            height: 20,
          ),


          FormHelper.inputFieldWidget(
              context,
              "message",
              "message",
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
            height:80,
          ),
          Center(
            child: FormHelper.submitButton(
              "Send",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });
          
                  Contact contact = Contact(
                    email: email,
                    message:message
                  );

                  Contact.send(contact).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Contact",
                          "Sent the message",
                          "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (route) => false,
                            );
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Contact",
                          "Failed to send",
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
}
