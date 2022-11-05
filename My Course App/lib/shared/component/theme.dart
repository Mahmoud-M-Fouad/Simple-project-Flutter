import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ThemeCubit extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
  );

  /// Toggles the current brightness between light and dark.
  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}

TextStyle get headingStyle{
  return  const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    overflow:TextOverflow.ellipsis ,
    color:Colors.black,
  );
}
TextStyle get headingStyleWhite{
  return  const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    overflow:TextOverflow.ellipsis ,
    color:Colors.white,
  );
}
TextStyle get headingStyleWhite2{
  return  const TextStyle(
    fontSize: 20,
    overflow:TextOverflow.ellipsis ,
    color:Colors.white,
  );
}
TextStyle get headingStyle2{
  return  const TextStyle(
    fontSize: 18,
    overflow:TextOverflow.ellipsis ,
    color:Colors.black45,
  );
}
TextStyle get headingStyle3{
  return  const TextStyle(
    fontSize: 14,
    overflow:TextOverflow.ellipsis ,
    color:Colors.black45,
  );
}