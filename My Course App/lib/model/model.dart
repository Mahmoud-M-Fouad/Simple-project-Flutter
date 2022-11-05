class Course{
  late final int id ;
  late final String name;
  late final String teacher;
  late final String day;
  late final String hour ;
  late final String type ;
  late final String phone;

  Course(
  {
   required this.id,
    required this.name,
    required this.teacher,
    required this.day,
    required this.hour,
    required this.type,
    required this.phone,
  });

  Map<String ,dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'teacher':teacher,
      'day':day,
      'hour':hour,
      'type':type,
      'phone':phone,

    };
  }

  @override
  String toString() {
    return 'Course {id : $id ,name : $name , teacher : $teacher , day : $day , hour : $hour , phone : $phone , type : $type}';
  }


}