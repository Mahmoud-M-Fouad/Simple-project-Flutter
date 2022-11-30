import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = "/Filtera";
  final Function saveFilters ;
  final Map<String, bool> currentFilter;

   FilterScreen(this.currentFilter,this.saveFilters);


  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget bulidSwitch(
      String Tit, String subTit, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(Tit),
      value: currentValue,
      subtitle: Text(subTit),
      onChanged: updateValue,
    );
  }

  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegan = false;
  bool isVegetarian = false;
@override
  void initState() {
  isGlutenFree = widget.currentFilter['GlutenFree'];
  isLactoseFree = widget.currentFilter['LactoseFree'];
  isVegan = widget.currentFilter['Vegan'];
  isVegetarian = widget.currentFilter['Vegetarian'];

    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed:(){
            final Map <String,bool> selectedFilter   = {
              "GlutenFree" : isGlutenFree ,
              "LactoseFree" :isLactoseFree ,
              "Vegan" : isVegan,
              "Vegetarian" : isVegetarian ,

            };
            widget.saveFilters(selectedFilter);
          }
          )

        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust Your Meal Selection",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              bulidSwitch( "Gluten-free", "Only Include Gluten-free Meals", isGlutenFree, (e) {
                setState(() {
                    isGlutenFree = e;
                  });},),
              //-------------------------
              bulidSwitch( "Vegetarian", "Only Include Vegetarian Meals", isVegetarian, (e) {
                setState(() {
                  isVegetarian = e;
                });},),
              ///--------------------------
              bulidSwitch( "LactoseFree", "Only Include LactoseFree Meals", isLactoseFree, (e) {
                setState(() {
                  isLactoseFree = e;
                });},),
              ///--------------------------
              bulidSwitch( "Vegan", "Only Include Vegan Meals", isVegan, (e) {
                setState(() {
                  isVegan = e;
                });},),
              ///--------------------------
            ],
          ))
        ],
      ),
    );
  }
}
