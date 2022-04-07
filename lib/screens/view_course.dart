import 'package:flutter/material.dart';
import 'package:frontend/services/cart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../services/course.dart';

class ViewCourse extends StatefulWidget {
  final Course course;

  const ViewCourse({Key? key, required this.course}) : super(key: key);

  @override
  State<ViewCourse> createState() => _ViewCourseState();
}

class _ViewCourseState extends State<ViewCourse> {
  bool? status;
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bool response = await Cart.IsItemAdded(widget.course.courseId);
    setState(() {
      status = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course - ${widget.course.courseName}'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  widget.course.courseImage,
                  width: 800,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              '${widget.course.courseName}',
              textAlign: TextAlign.left,
              style: GoogleFonts.oswald(fontSize: 35),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              '${widget.course.courseDescription}',
              style: GoogleFonts.oswald(fontSize: 30, color: Colors.grey),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              'Course price: RS ${widget.course.coursePrice}.00',
              style: GoogleFonts.oswald(fontSize: 20),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.orange,
                  onSurface: Colors.grey,
                  side: BorderSide(color: Colors.black, width: 1),
                  minimumSize: Size(150, 50),
                ),
                onPressed: status == false
                    ? () {
                        final Cart cart = Cart(
                            cartId: '',
                            courseId: widget.course.courseId,
                            status: 'pending');
                        Cart.addToCart(cart).then(
                          (response) {
                            if (response != null) {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                "Course App",
                                "Course Successfully Added To The Cart",
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
                                "Course App",
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
                    : null,
                child: Text("Add To Cart",
                    style: GoogleFonts.oswald(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
