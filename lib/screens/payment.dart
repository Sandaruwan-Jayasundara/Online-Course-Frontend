import 'package:flutter/material.dart';
import 'package:frontend/services/creditCard.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../services/user.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  
  String? cardName;
  String? cardNumber;
  int? cardCvv;
  String? cardDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        backgroundColor: HexColor("#ffffff"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 0, 23, 99),
                        Color.fromARGB(255, 0, 23, 99),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/Logo/pay.png",
                    fit: BoxFit.contain,
                    
                    width: 250,
                  ),
                ),
              ],
            ),
          ),
            const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 60),
            child: Text(
              "Save Your Card",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 1, 37, 99),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: FormHelper.inputFieldWidget(
              context,
              "CardNumber",
              "Card Number",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Card Number can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                cardNumber = onSavedVal,
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
            padding: const EdgeInsets.only(bottom: 15),
            child: FormHelper.inputFieldWidget(
              context,
              "CardHolderName",
              "Card Holder Name",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Name can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                cardName = onSavedVal,
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
            padding: const EdgeInsets.only(bottom: 15),
         

            child: FormHelper.inputFieldWidget(
              context,
              "Date",
              "Date",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Name can\'t be empty.';
                }

                return null;
              },
              
              (onSavedVal) => {
                cardDate = onSavedVal,
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
            padding: const EdgeInsets.only(bottom: 20),
         

            child: FormHelper.inputFieldWidget(
              context,
              "cvv",
              "CVV",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'CVV can\'t be empty.';
                }

                return null;
              },
              
              (onSavedVal) => {
                cardCvv = onSavedVal,
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
              "SAVE CARD",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });
          
                   CreditCard card = CreditCard(
                    cardName: cardName,
                    cardNumber: cardNumber,
                    cvv: cardCvv,
                    date: cardDate
                  );

                
                  CreditCard.Payment(card).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response != null) {
                         Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                              (route) => false,
                            );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Course App",
                          "Login failed",
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
