import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
      ),
      body: Center(
      
        child: Container(
          color: Color.fromRGBO(241, 238, 238, 1.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                  elevation: 20.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15.0,),
                      Text(
                        'About',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                      SizedBox(height: 15.0),
                      Text('This app is completely for educational purpose'),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 10.0),
                        child:
                      Text(
                        'RecipeList App can be used to see the different kinds of recipes from ' +
                            'different regions. App Users can also share their own recipes which will be added ' +
                            'back to our server . Users can add their favourite recipe to favourite list and can view' +
                            ' them later.',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w600,wordSpacing: 4.0),
                            textAlign: TextAlign.center,
                      ),),
                      SizedBox(height: 20.0,),
                      Text('This app is built for as a project for Ty. B.Sc Computer Science SEM V',  style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w600,wordSpacing: 2.0,color: Colors.red),
                            textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.0,),
                    ],
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}
