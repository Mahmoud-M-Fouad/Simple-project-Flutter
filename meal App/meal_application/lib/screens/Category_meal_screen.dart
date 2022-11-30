
import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../models/meal.dart';
import '../widgets/MealItem.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName ="category_meals";
  final List<Meal> avalMealss;

  const CategoryMealScreen(this.avalMealss);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> dispMeals;
  @override
void didChangeDependencies() {
    final routeArg = ModalRoute.of(context).settings.arguments as Map <String,String >;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    dispMeals =  widget.avalMealss.where((e) {
      return e.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override

  Function _removeMeal(String id)
  {
    setState(() {
      dispMeals.removeWhere((e) => e.id==id);
    });
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx,index){
          return MealItem(
            title: dispMeals[index].title,
            duration: dispMeals[index].duration,
            complexity: dispMeals[index].complexity,
            affordability: dispMeals[index].affordability,
            imageUrl: dispMeals[index].imageUrl,
            id: dispMeals[index].id,
            removeItem: _removeMeal,

          );
        },
        itemCount: dispMeals.length ,
      ),
    );
  }
}
