import 'package:flutter/material.dart';
import 'package:frontend/services/creditCard.dart';



class cardTitle extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

  CreditCard.DisplayCard().then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response !=null) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Course App",
                          "Invalid Username/Password !!",
                          "OK",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
               
    return Card(
      elevation: 3,
      child: Column(
        children: [
          Expanded(child: Image.network(card.cardNumber)),
          Text(
            card.cardNumber,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            '${card.cardName}',
            style: Theme.of(context).textTheme.caption,
          ),
          
        ],
      ),
    );
  }
}
