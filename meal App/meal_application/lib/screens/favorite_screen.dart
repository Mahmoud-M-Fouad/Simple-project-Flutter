import 'package:flutter/material.dart';
import '../widgets/MealItem.dart';
import '../models/meal.dart';

class Favorite_screen extends StatelessWidget {
  final List<Meal> favoMeal;
  const Favorite_screen(this.favoMeal);
  @override
  Widget build(BuildContext context) {
    if(favoMeal.isEmpty) {
      return Center(
        child: Text("You Favorites Yet -start Adding Some!"),

      );
    }
    else
      {
        return ListView.builder(
          itemBuilder: (ctx,index){
            return MealItem(
              title: favoMeal[index].title,
              duration: favoMeal[index].duration,
              complexity: favoMeal[index].complexity,
              affordability: favoMeal[index].affordability,
              imageUrl: favoMeal[index].imageUrl,
              id: favoMeal[index].id,


            );
          },
          itemCount: favoMeal.length ,
        );
      }
  }
}
