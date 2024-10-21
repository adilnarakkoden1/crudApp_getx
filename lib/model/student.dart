import 'package:hive/hive.dart';
part 'student.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String age;
  @HiveField(2)
  late String place;
  @HiveField(3)
  late String course;
  @HiveField(4)
  late String image;
  
}
