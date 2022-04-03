import 'package:flutter/material.dart';
import 'package:frontend/theme/color.dart';
import 'package:frontend/utils/data.dart';

import '../components/course_tile.dart';
import '../components/home_course_tile.dart';
import '../services/category.dart';
import '../services/course.dart';
import '../widgets/notification_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> _categories = [];
  String? filter;

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: Column(
          children: [
            Flexible(flex: 3, child: getAppBar()),
            Flexible(flex: 3, child: categoryList()),
            filter != null
                ? Flexible(flex: 15, child: filteredCourseList())
                : Flexible(flex: 15, child: courseList())
          ],
        ));
  }

  Widget getAppBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
      ),
    );
  }

  Widget categoryList() {
    return Container(
      height: 50,
      child: (ListView.builder(
          itemCount: _categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filter = _categories.elementAt(index).CategoryName!;
                      });
                    },
                    child:
                        Text('${_categories.elementAt(index).CategoryName}')),
                SizedBox(
                  width: 20,
                )
              ],
            );
          })),
    );
  }

  Widget courseList() {
    return (Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: Course.getAllCourses(),
          builder: (context, AsyncSnapshot<List<Course>> snapshot) {
            List<Course>? courses = snapshot.data;
            if (snapshot.hasData) {
              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: courses!
                    .map((Course course) => HomeCourseTile(course: course))
                    .toList(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    ));
  }

  Widget filteredCourseList() {
    return (Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: Course.getAllCourses(),
          builder: (context, AsyncSnapshot<List<Course>> snapshot) {
            List<Course>? courses = snapshot.data;
            if (snapshot.hasData) {
              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: courses!
                    .where((element) =>
                        element.courseCategory == filter ? true : false)
                    .map((Course course) => HomeCourseTile(course: course))
                    .toList(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    ));
  }

  loadCategoryData() async {
    List<Category> Data = await Category.getAllCategories();
    setState(() {
      _categories = Data;
    });
    print("dfdf");
  }
}
