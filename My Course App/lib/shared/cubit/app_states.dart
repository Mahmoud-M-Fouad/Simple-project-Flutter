abstract class AppStates {}

class AppInitialState  extends AppStates {}

class ChangeIndexScreen extends AppStates {}
class RefreshScreen extends AppStates {}
class GetAllCourses extends AppStates {
  var list;
  GetAllCourses(this.list);
}


