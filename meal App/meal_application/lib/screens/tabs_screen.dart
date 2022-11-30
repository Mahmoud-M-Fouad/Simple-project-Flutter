import 'package:flutter/material.dart';
import 'package:meal_application/models/meal.dart';
import 'package:meal_application/screens/favorite_screen.dart';
import 'package:meal_application/screens/main_drawer.dart';
import '../screens/categort_screen.dart';

class Tabs_screen extends StatefulWidget {
  final List<Meal> favoMeal;
  const Tabs_screen(this.favoMeal);

@override
  _Tabs_screenState createState() => _Tabs_screenState();
}

class _Tabs_screenState extends State<Tabs_screen> {


 List<Map<String,Object>> _page ;



  int _selectPageIndex = 0;

@override
  void initState() {
    _page =
  [
  {
  'page': Category_screen(),
  'title': 'Categories',
  },
  {
  'page': Favorite_screen(widget.favoMeal),
  'title': 'Your Favorites',
  }
  ];
    super.initState();
  }
  void _selectPage(int s)
  {
    setState(() {
      _selectPageIndex = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_selectPageIndex]['title']),

      ),
      body:_page[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.white,
      currentIndex: _selectPageIndex,
      backgroundColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.category),
          title: Text("Categories"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: Text("Favoriates"),
        ),
      ],
      ),
      drawer: Main_drawer(),
    );
  }
}
