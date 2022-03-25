import 'package:flutter/material.dart';
import 'package:frontend/utils/data.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../https/api.dart';
import '../models/CourseModel.dart';
import 'courseItem.dart';

class CourseList extends StatefulWidget {
  const CourseList({ Key? key }) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();

    courses.add(
      CourseModel(
        id: "1",
        courseName: "Haldiram",
        courseImage:
            "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=85,metadata=none,w=400,h=400/app/images/products/full_screen/pro_86973.jpg",
        courseDescription: "Haldiram Foods",
        coursePrice: 500,
      ),
    );

    courses.add(
     CourseModel(
        id: "1",
       courseName: "Haldiram",
        courseImage:
            "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=85,metadata=none,w=400,h=400/app/images/products/full_screen/pro_86973.jpg",
        courseDescription: "Haldiram Foods",
        coursePrice: 500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        child: loadCourse(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

  Widget loadCourse() {
    return FutureBuilder(
      future: Api.getCourse(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<CourseModel>?> model,
      ) {
        if (model.hasData) {
          return courseList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget courseList(courses) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.green,
                  minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/add-course',
                  );
                },
                child: const Text('Add Course'),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return CourseItem(
                    model: courses[index],
                    onDelete: (CourseModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      Api.deleteCourse(model.id).then(
                        (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}