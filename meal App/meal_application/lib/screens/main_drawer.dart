import 'package:flutter/material.dart';
import 'package:meal_application/screens/FilterScreen.dart';

class Main_drawer extends StatelessWidget {
  Widget bulidListViwe(String s, IconData icn,Function f)
  {
    return ListTile(
      leading: Icon(icn,size: 26,),
      title: Text(s,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
      onTap: f,

    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120, width: double.infinity,padding: EdgeInsets.all(20),color: Colors.amberAccent,
            alignment: Alignment.centerLeft,
            child: Text("Cooking Up!",style: TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 20,),
          bulidListViwe("Meal", Icons.restaurant,(){Navigator.of(context).pushNamed('/');}),
          bulidListViwe("Filters", Icons.settings,(){Navigator.of(context).pushNamed(FilterScreen.routeName);}),


        ],
      ),
    );
  }
}
