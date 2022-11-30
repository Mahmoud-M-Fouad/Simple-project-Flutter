import 'package:flutter/material.dart';
import 'package:meal_application/screens/Category_meal_screen.dart';

class Category_item extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  Category_item(this.id,this.title,this.color);
void SelectCategory(BuildContext ctx)
{
  Navigator.of(ctx).pushNamed(CategoryMealScreen.routeName,
  arguments: {
    "id":id,
      "title":title,

      },
  );
}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>SelectCategory(context),
      splashColor: Colors.amberAccent,
        borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title,style: TextStyle(fontSize: 20,color: Colors.black),textAlign: TextAlign.center,),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:[
              color.withOpacity(0.5),
              color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: color,
          borderRadius: BorderRadius.circular(15)
        ),

      ),
    );
  }
}
