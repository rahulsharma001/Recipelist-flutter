import 'package:flutter/material.dart';
import './Pages/recipeAdd.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
       routes: {
    '/second': (context) => MyApp(),
  },
      home: Builder(builder: (context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 5.0,
          child: Icon(Icons.add),
          onPressed: () {
           Navigator.pushNamed(context,'/second');
          },
        ),
        appBar: AppBar(
          title: Text('Recipe List'),
        ),
        // body: buildv(),
      ),
    ),);
  }
}
