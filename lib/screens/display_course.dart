import 'package:flutter/material.dart';
import 'package:frontend/screens/add_courses.dart';
import 'package:frontend/services/course.dart';


class CourseDisplay extends StatelessWidget {
  const CourseDisplay({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
        title: const Center(child: Text("ADMIN COURSE")),
        actions: [
          IconButton(
              onPressed: () {
               Navigator.pushNamed(context, Addcourses.routeName);
              },
              icon: const Icon(Icons.ad_units))
        ],
      ),

      
   body: FutureBuilder(
          future: Course.getAllCourses(),
          builder: (context, AsyncSnapshot<List<Course>> snapshot) {
            List<Course>? posts = snapshot.data;
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 3,
                children: posts!
                    .map((Course post) => Card(
                          child: ListTile(
                            // title: Text(post.courseId),
                            onTap: () {
              
                            },
                          ),
                        ))
                    .toList(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}