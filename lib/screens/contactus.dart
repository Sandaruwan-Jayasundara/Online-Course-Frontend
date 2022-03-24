import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({ Key? key }) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Contact Us",
            style: TextStyle(color: Color.fromARGB(255, 17, 7, 107)),
          ),
          backgroundColor: Colors.white, //shade
          elevation: 0,
        ),
        // backgroundColor: Colors.blueGrey,
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Center(
                child: Image.asset(
             "assets/Logo/contact_us.png",
              height: 100,
            )),
       
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20,
                      ),
                    ]),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.alternate_email,
                          color: Color.fromARGB(255, 11, 5, 99),
                          size: 50,
                        ),
                        Text("Write to Us"),
                        Text("help@gmail.com"),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20,
                      ),
                    ]),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.help_outline,
                          color: Color.fromARGB(255, 11, 5, 99),
                          size: 50,
                        ),
                        Text("FAQs"),
                        Text(
                          "Frequently Asked Questions",
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20,
                      ),
                    ]),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 11, 5, 99),
                          size: 50,
                        ),
                        Text("Phone Number"),
                        Text("+9454215486"),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20,
                      ),
                    ]),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.location_city,
                          color: Color.fromARGB(255, 11, 5, 99),
                          size: 50,
                        ),
                        Text("Address"),
                        Text("Colombo"),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
                
              ],
            ),
                  const SizedBox(
              height: 60,
            ),
              const Text(
              "If you need help \n please contact us!",
              style: TextStyle(fontSize: 15, color: Colors.blueGrey),
            ),
  const SizedBox(
              height: 40,
            ),

             RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14.0),
                  children: <TextSpan>[
              
                    TextSpan(
                      text: 'Contact us',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 7, 13, 100),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            '/chat',
                          );
                        },
                    ),
                  ],
                ),
              ),

            
          ],
        ),
      ),
    );
  }
}