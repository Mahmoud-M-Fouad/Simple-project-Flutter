import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_course/shared/cubit/app_states.dart';

import '../component/db.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState()) ;
  static AppBloc get (context) => BlocProvider.of(context);

  int indexScreen = 0;
  var listOfCourses;

  int get getIndex => indexScreen;
   setIndex({required int index})
  {
    indexScreen = index;
    emit(ChangeIndexScreen());
  }

  getCourses({required String day })
  {
    course(day).then((value){
      listOfCourses = value;
    });
    emit(GetAllCourses(listOfCourses));
  }
  refresh()
  {
    emit(RefreshScreen());
  }


}