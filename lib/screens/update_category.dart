import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/utils/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../services/category.dart';
import '../widgets/custom_image.dart';

class UpdateCategory extends StatefulWidget {
  final Category category;
  const UpdateCategory({Key? key, required this.category}) : super(key: key);

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  bool isApiCallProcess = false;

  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? CategoryName;
  String? CategoryNumber;

  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;
  File? categoryImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
                       title: Center(
            child:
                Text('Update Category', style: GoogleFonts.oswald(fontSize: 25)),
          ),
          backgroundColor: Colors.orange,
        ),
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
          const SizedBox(
            height: 60,
          ),
          CustomImage(
            categoryIcon["image"]!,
            width: 100,
            height: 100,
            radius: 20,
          ),
          const SizedBox(
            height: 60,
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
              initialValue: widget.category.CategoryName!,
              obscureText: false,
              borderFocusColor: Color.fromARGB(255, 1, 37, 99),
              prefixIconColor: Color.fromARGB(255, 1, 37, 99),
              borderColor: Color.fromARGB(255, 1, 37, 99),
              textColor: Color.fromARGB(255, 0, 0, 0),
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
              initialValue: widget.category.CategoryNumber!,
              borderFocusColor: Color.fromARGB(255, 1, 37, 99),
              prefixIconColor: Color.fromARGB(255, 1, 37, 99),
              borderColor: Color.fromARGB(255, 1, 37, 99),
              textColor: Color.fromARGB(255, 1, 37, 99),
              hintColor: Color.fromARGB(255, 1, 37, 99).withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          imageprofile(),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: FormHelper.submitButton(
              "UPDATE",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  Category category = Category(
                    categoryId: widget.category.categoryId,
                    CategoryName: CategoryName,
                    CategoryNumber: CategoryNumber,
                    CategoryImage: widget.category.categoryId,
                  );

                  (categoryImage == null
                          ? Category.updateCategoryWithoutImage(category)
                          : Category.updateCategory(category, categoryImage!))
                      .then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Category",
                          "Category Updated.",
                          "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/category',
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

  Widget imageprofile() {
    return Center(
      child: Stack(
        children: [
          categoryImage != null
              ? Image.file(categoryImage!, height: 160, width: 160)
              : Image.asset(
                  widget.category.CategoryImage!,
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
      this.categoryImage = imageTemporary;
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
