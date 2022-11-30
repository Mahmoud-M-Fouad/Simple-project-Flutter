import 'package:flutter/material.dart';
import 'package:meal_application/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = "MealDetails";
  final Function TogFav ;
  final Function IsMealFavoirt;

  const MealDetailsScreen(this.TogFav,this.IsMealFavoirt);


  Widget bulidSectionTitle(String s)
  {
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
       s,style: TextStyle(fontSize: 25),
      ),
    );
  }
  Widget buildContainer(Widget child)
  {
    return Container(height: 220,width: 300,
      decoration: BoxDecoration(
        color: Colors.white12,
        border: Border.all(color: Colors.pink),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child:child
    );
  }
  @override
  Widget build(BuildContext context) {
    final MealId =ModalRoute.of(context).settings.arguments as String ;
    final selectedMeal = DUMMY_MEALS.firstWhere((e) => e.id == MealId);


    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(selectedMeal.imageUrl,fit: BoxFit.cover,),
            ),
            bulidSectionTitle( "Ingredient"),

            buildContainer(ListView.builder(
              itemBuilder: (ctx,index)=>Card(
                color: Colors.amberAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(selectedMeal.ingredients[index],style: TextStyle(fontSize: 17),),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,

            ),),
            bulidSectionTitle( "Steps"),
            buildContainer(ListView.builder(
              itemBuilder: (ctx,index)=>Column(
                children: [
              ListTile(
              leading: CircleAvatar(

              child: Text("# ${index+1}",style: TextStyle(color:Colors.black),),
                backgroundColor: Colors.amberAccent,
            ),
              title:  Text(selectedMeal.steps[index],style: TextStyle(fontSize: 17),),
            ),
                  Divider(),
                ],

              ),
              itemCount: selectedMeal.steps.length,
            ),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>TogFav(MealId),
        child: Icon(
            IsMealFavoirt(MealId)?Icons.star:Icons.star_border,

        )
      ),
    );
  }
}
