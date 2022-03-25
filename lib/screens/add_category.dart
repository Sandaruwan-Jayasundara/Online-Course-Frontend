import 'package:flutter/material.dart';
import 'package:frontend/services/category.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class AddCategory extends StatefulWidget {
    static String routeName = '/addcategory';
  const AddCategory({ Key? key }) : super(key: key);
  
@override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool isApiCallProcess = false;

  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? CategoryName;
  String? CategoryNumber;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


   return SafeArea( 
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: addCategoryForm(),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget addCategoryForm() {
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
                CategoryName = onSavedVal, 
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
                  return 'Category Number can\'t be empty.';
                }
                return null;
              },
              (onSavedVal) => {
                CategoryNumber = onSavedVal,
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
          
                  Category category = Category(
                    CategoryName: CategoryName,
                    CategoryNumber: CategoryNumber,

                  );

                  Category.addNewCategory(category).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Category",
                          "Category Added.",
                          "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/admin',
                              (route) => false,
                            );
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Category",
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
