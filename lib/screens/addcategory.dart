import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({ Key? key }) : super(key: key);
  
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? userName;
  String? password;
  String? email;

  String dropdownvalue = 'Item 1';   
  
  // List of items in our dropdown menu
  var items = [    
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#f2f2f2"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _addCategoryUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
    
  }

  Widget _addCategoryUI(BuildContext context) {



    return SingleChildScrollView(
      child: Column(

        children: <Widget>[
     
      const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 80, top: 50),
            child: Text(
              "ADD CATEGORY",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromARGB(255, 1, 37, 99),
              ),
            ),
          ),

















          
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: FormHelper.inputFieldWidget(
              context,
              "CategoryName",
              "Category Name",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'CategoryName can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                userName = onSavedVal,
              },
              initialValue: "",
              obscureText: false,
              borderFocusColor: Color.fromARGB(255, 1, 37, 99),
              prefixIconColor: Color.fromARGB(255, 1, 37, 99),
              borderColor: Color.fromARGB(255, 1, 37, 99),
              textColor: Color.fromARGB(255, 1, 37, 99),
              hintColor: Color.fromARGB(255, 1, 37, 99).withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
           padding: const EdgeInsets.only(bottom: 25),
            child: FormHelper.inputFieldWidget(
              context,
             "CategoryNumber",
              "Category Number",
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
              borderFocusColor: Color.fromARGB(255, 1, 37, 99),
              prefixIconColor: Color.fromARGB(255, 1, 37, 99),
              borderColor: Color.fromARGB(255, 1, 37, 99),
              textColor: Color.fromARGB(255, 1, 37, 99),
              hintColor: Color.fromARGB(255, 1, 37, 99).withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
          padding: const EdgeInsets.only(bottom: 25),
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
              "CREATE",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });
          
                  // User user = User(
                  //   name: userName,
                  //   email: email,
                  //   password: password,
                  // );

                  // User.registerUser(user).then(
                  //   (response) {
                  //     setState(() {
                  //       isApiCallProcess = false;
                  //     });

                  //     if (response != null) {
                  //       FormHelper.showSimpleAlertDialog(
                  //         context,
                  //         "Course App",
                  //         "Registration Successful. Please login to the account",
                  //         "OK",
                  //         () {
                  //           Navigator.pushNamedAndRemoveUntil(
                  //             context,
                  //             '/',
                  //             (route) => false,
                  //           );
                  //         },
                  //       );
                  //     } else {
                  //       FormHelper.showSimpleAlertDialog(
                  //         context,
                  //         "Course App",
                  //         "Login failed",
                  //         "OK",
                  //         () {
                  //           Navigator.of(context).pop();
                  //         },
                  //       );
                  //     }
                  //   },
                  // );
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
