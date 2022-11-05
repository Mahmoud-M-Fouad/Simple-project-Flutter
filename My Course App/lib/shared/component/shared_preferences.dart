import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedClass{
  static late SharedPreferences sharedPreferences;

  static inti() async {
    sharedPreferences =  await SharedPreferences.getInstance();
  }

  Future<bool> putList({required String key,required var list})
  {
    return sharedPreferences.setInt(key, list);
  }
  static setCounter({required int count,required String key})
  {
    return sharedPreferences.setInt(key, count);
  }
  static getCounter({required String key})
  {
    return sharedPreferences.getInt(key);
  }

 static setId({required String key,required int num})
  {
    return sharedPreferences.setInt(key, num);
  }

  static getInt({required String key})
  {
    return sharedPreferences.getInt(key);
  }

  static setlang({required String key,required String num})
  {
    return sharedPreferences.setString(key, num);
  }

  static getlang({required String key})
  {
    return sharedPreferences.getString(key);
  }
}