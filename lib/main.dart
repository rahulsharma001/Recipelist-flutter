import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{

  TextEditingController title=new TextEditingController();
  TextEditingController description=new TextEditingController();

Future<List> submitRecipe() async{
  final response=await http.post('http://localhost:8000/api/submitRecipe' ,body:{
    'title':title.text,
    'description':description.text
  });

  print(response);
}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 5.0,
          child: Icon(Icons.add),
          onPressed: () {
            print('floating');
          },
        ),
        appBar: AppBar(
          title: Text('Recipe List'),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: title,
                obscureText: true,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Recipe Name',
                ),
              ),
              TextFormField(
                controller: description,
                decoration: InputDecoration(
                  labelText: 'Recipe Description',
                ),
                maxLines:5,
              ),
              SizedBox(
                height:10.0,
              ),
              RaisedButton(
                child:Text('Submit'),
                color: Colors.white,
                elevation: 4.0,
                onPressed: (){
                  submitRecipe();
                  print('Onpressed clicked');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
