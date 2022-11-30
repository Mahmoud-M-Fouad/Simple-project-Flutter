import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/MealDetailsScreen.dart';

class MealItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int duration ;
  final Complexity complexity;
  final Affordability affordability;
  final String id;
  final Function removeItem;


  MealItem(
      {
        @required this.imageUrl, @required this.title, @required this.duration, @required this.complexity, @required this.affordability, @required this.id,@required this.removeItem
      });

void selectItem(BuildContext ctx)
{
Navigator.of(ctx).pushNamed(MealDetailsScreen.routeName,
arguments: id,
).then((value){
  if(value!=null)
    removeItem(value);

});
}
String get complexityText{
  switch(complexity)
  {
    case Complexity.Simple : return "Simple";break;
    case Complexity.Challenging : return "Challenging";break;
    case Complexity.Hard  : return "Hard";break;
    default : return "null";break;
  }
}

  String get AffordabilityText{
    switch(affordability)
    {
      case Affordability.Pricey : return "Pricey";break;
      case Affordability.Luxurious : return "Luxurious";break;
      case Affordability.Affordable  : return "Affordable";break;
      default : return "null";break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>selectItem(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
          margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                  ),
                  child: Image.network(imageUrl,height: 200,width: double.infinity,fit: BoxFit.cover,),

                ),
                Positioned
                  (bottom: 20,right: 10,
                    child: Container(width: 220,color: Colors.black45,padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                        child: Text(title,style: TextStyle(fontSize: 20,color: Colors.cyanAccent),softWrap: true,overflow: TextOverflow.fade,))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule),
                    SizedBox(width: 6,),
                    Text("$duration min"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.work),
                    SizedBox(width: 6,),
                    Text("$complexityText"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.attach_money_outlined),
                    SizedBox(width: 6,),
                    Text("$Affordability"),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
