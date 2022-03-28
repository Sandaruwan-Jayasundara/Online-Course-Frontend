import 'package:flutter/material.dart';
import 'package:frontend/theme/color.dart';
import 'package:frontend/utils/data.dart';

import '../components/course_tile.dart';
import '../components/home_course_tile.dart';
import '../services/course.dart';
import '../widgets/notification_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: Column(
          children: [
            Flexible(
              flex: 3,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: appBarColor,
                    pinned: true,
                    snap: true,
                    floating: true,
                    title: getAppBar(),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: Course.getAllCourses(),
                    builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                      List<Course>? courses = snapshot.data;
                      if (snapshot.hasData) {
                        return GridView.count(
                          crossAxisCount: 2,
                          children: courses!
                              .map((Course course) =>
                                  HomeCourseTile(course: course))
                              .toList(),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
            )
          ],
        ));
  }

  Widget getAppBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile["name"]!,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Good Morning!",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
            ],
          )),
          NotificationBox(
            notifiedNumber: 1,
            onTap: () {},
          )
        ],
      ),
    );
  }
}
