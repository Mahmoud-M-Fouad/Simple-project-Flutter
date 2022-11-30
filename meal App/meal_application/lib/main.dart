import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/Category_meal_screen.dart';
import './screens/FilterScreen.dart';
import './screens/MealDetailsScreen.dart';
import './screens/tabs_screen.dart';
import './screens/categort_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map <String, bool >filters = {
  "GlutenFree" : false ,
  "LactoseFree" :false ,
  "Vegan" : false ,
  "Vegetarian" : false ,
  };


  List<Meal> avalMeal = DUMMY_MEALS;
  List<Meal> favoMeal = [];
  bool IsMealFavoirt(String id)
  {
    return favoMeal.any((e) => e.id==id);
  }
  void togFavo(String MealID)
  {
    final exitIndex = favoMeal.indexWhere((e) => e.id==MealID);
    if (exitIndex>=0)
      {
        setState(() {
          favoMeal.removeAt(exitIndex);
        });
      }
    else
      {
        setState(() {
          favoMeal.add(DUMMY_MEALS.firstWhere((e) => e.id==MealID));
        });
      }
  }
void setFilter ( Map <String, bool >filtersDate)
{
  setState(() {
    filters = filtersDate;
    avalMeal = DUMMY_MEALS.where((e){
      if(filters ['GlutenFree'] && !e.isGlutenFree)
        return false;
      if(filters ['LactoseFree'] && !e.isLactoseFree)
        return false;
      if(filters ['Vegan'] && !e.isVegan)
        return false;
      if(filters ['Vegetarian'] && !e.isVegetarian)
        return false;
      return true;
    }).toList();

  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Apple',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //home: Category_screen(),
      //home: Category_screen(),
      routes: {
        '/': (context)=>Tabs_screen(favoMeal),
        CategoryMealScreen.routeName : (context)=>CategoryMealScreen(avalMeal),
        MealDetailsScreen.routeName : (context)=>MealDetailsScreen(togFavo,IsMealFavoirt),
        FilterScreen.routeName : (context)=>FilterScreen(filters,setFilter),


      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Meal App"),

      ),
      body: null,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
