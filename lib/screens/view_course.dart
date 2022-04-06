import 'package:flutter/material.dart';
import 'package:frontend/services/cart.dart';
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
        title: Text('${widget.course.courseName}'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                widget.course.courseImage,
                width: 800,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              '${widget.course.courseName}',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              '${widget.course.courseDescription}',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              'Course price: ${widget.course.coursePrice}',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            ElevatedButton(
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
                child: Text("Add To Cart")),
          ],
        ),
      ),
    );
  }
}
