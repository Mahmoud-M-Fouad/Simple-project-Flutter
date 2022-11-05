import 'package:flutter/material.dart';
import 'package:my_course/shared/component/component.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/model.dart';


  late final Future<Database> database;
  Future<void> CreateDatabase() async
  {
      database = openDatabase(
      join(await getDatabasesPath() ,
          'mycourse_database.db'),
      onCreate: (db , version)
      {
        return db.execute("CREATE TABLE course (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,"
            " name TEXT NOT NULL ,teacher TEXT NOT NULL,"
            "day TEXT NOT NULL,hour TEXT NOT NULL,type TEXT NOT NULL,"
            "phone TEXT NOT NULL) "
        ).then((value){
          print("Database Created");
          var math = Course( id: 0, name: "aa", teacher: "aa", day: "aa", hour:"aa", phone:"aa", type: 'as');
          Init_insertCousre(math);
        });

      },
      version: 1,
    );

  }

  Future<void> insertCourse(Course c ,  BuildContext context)async{
    final Database db = await database;
    await db.insert('course', c.toMap(), conflictAlgorithm: ConflictAlgorithm.replace
    ).then((value) {
      showToast(
        context: context,
        msg: "تم إضافة الدرس بنجاح",
        color: Colors.green,
      );
    }
    ).catchError((e){
      showToast(
        context: context,
        msg: "فشل إضافة هذا الدرس ",
        color: Colors.red,
      );
    });
  }

Future<void> Init_insertCousre(Course c)async{
  final Database db = await database;
  await db.insert('course', c.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Course>> course(String day ) async {
    final Database db =await database;
    final List<Map<String , dynamic>> map = await db.query('course' ,
         where: "day = ? " , whereArgs: [day]
    );
    return List.generate(map.length,
            (index)
        {
          return Course(
            id: map[index]['id'],
            name: map[index]['name'],
            teacher: map[index]['teacher'],
            day: map[index]['day'],
            hour: map[index]['hour'],
            type: map[index]['type'],
            phone: map[index]['phone'],
          );
        }
    );
  }



Future<bool> Check_course_day(String day ) async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('course' ,
      where: "day = ? " , whereArgs: [day]
  );
  return map.isNotEmpty ?true : false;
}

Future<List<Course>> courseId(int id ) async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('course' ,
      where: "id = ? " , whereArgs: [id]
  );
  return List.generate(map.length,
          (index)
      {
        return Course(
          id: map[index]['id'],
          name: map[index]['name'],
          teacher: map[index]['teacher'],
          day: map[index]['day'],
          hour: map[index]['hour'],
          type: map[index]['type'],
          phone: map[index]['phone'],
        );
      }
  );
}

Future<List<Course>> Allcourse() async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('course' ,
  );
  return List.generate(map.length,
          (index)
      {
        return Course(
          id: map[index]['id'],
          name: map[index]['name'],
          teacher: map[index]['teacher'],
          day: map[index]['day'],
          hour: map[index]['hour'],
          type: map[index]['type'],
          phone: map[index]['phone'],
        );
      }
  );
}

Future<int> MaxCourseID() async {
var id;
  final Database db =await database;
 // final List<Map<String, dynamic>> map
id = Sqflite.firstIntValue(await db.rawQuery('SELECT max(id) FROM course'));

  return id;
}

Future<bool> checkAllCourse(int id) async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('course' ,
      where: "id = ? " , whereArgs: [id]
  );
  return map.isNotEmpty ?true : false;
}

Future<void> updateCourse(Course c , BuildContext context)async
{
    final db = await database ;
    await db.update('course', c.toMap() , where: "id = ? " , whereArgs: [c.id]
    ).then((value) {
      showToast(
        context: context,
        msg: "تم تعديل هذا الدرس بنجاح",
        color: Colors.green,
      );
    }
    ).catchError((e){
      showToast(
        context: context,
        msg: "فشل تعديل هذا الدرس ",
        color: Colors.red,
      );
    });
  }



Future<void> deleteCourse(int id ,BuildContext context)async
{
    final db = await database ;
    await db.delete('course', where: "id = ? " , whereArgs: [id]
    ).then((value) {
      showToast(
          context: context,
          msg: "تم حذف الدرس بنجاح",
          color: Colors.green,
      );
    }).catchError((error)
    {
      showToast(
        context: context,
        msg: "فشل حذف هذا الدرس ",
        color: Colors.red,
      );
    });
  }





// use it

/*
// 1.
var math = Course(id: 1, name: 'alaa', teacher: 'father', day: 'sunday', hour: 1, phone: '01012');
await insertCousre(math);


// 2.
var math2 = Course(id: 1, name: 'alaa', teacher: 'father', day: 'sunday', hour: 1, phone: '01012');
await UpdateCourse(math);
// 3.
await DeleteCourse(math.id);

// 4.
print(await course());


*/