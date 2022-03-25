List<CourseModel> courseFromJson(dynamic str) =>
    List<CourseModel>.from((str).map((x) => CourseModel.fromJson(x)));

class CourseModel {
  late String? id;
  late String? courseName;
  late String? courseDescription;
  late int? coursePrice;
  late String? courseImage;

  CourseModel({
    this.id,
    this.courseName,
    this.courseDescription,
    this.coursePrice,
    this.courseImage,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    courseName = json['courseName'];
    courseDescription = json['courseDescription'];
    coursePrice = json['coursePrice'];
    courseImage = json['courseImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['courseName'] = courseName;
    _data['courseDescription'] = courseDescription;
    _data['coursePrice'] = coursePrice;
    _data['courseImage'] = courseImage;
    return _data;
  }
}