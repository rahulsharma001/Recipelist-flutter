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

class _MyAppState extends State<MyApp> {
  var respond;
  String message = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController imgUrl = new TextEditingController();

  Future<List> submitRecipe() async {
    final response = await http.post('http://192.168.0.100/api/submitRecipe',
        body: {'title': title.text, 'description': description.text});
    respond = json.decode(response.body);
    print(respond);

    if (respond['errorCode'] == 0) {
      setState(() {
        print('Data Entered Successfully !!!');
        title.text = '';
        description.text = '';
        showInSnackBar('Data Entered Successfully');
      });
    } else {
      setState(() {
        print('Server Down!!!');
        showInSnackBar('Something Went Wrong !!! Try Again ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
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
        body: Builder(
          builder: (context) => Container(
                padding: EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      controller: title,
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
                      maxLines: 5,
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: (){
                        print('gesture recorderd !!!');
                      },
                      child: Container(
                        child: Image.asset('assets/logo.png',
                            height: 30.0, width: 30.0),
                      ),
                    ),
                    // TextFormField(
                    //   controller:imgUrl,
                    //   decoration:InputDecoration(
                    //     labelText:'Image Url',
                    //   )
                    // ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      child: Text('Submit'),
                      color: Colors.white,
                      elevation: 4.0,
                      onPressed: () {
                        submitRecipe();
                        print('Onpressed clicked');
                      },
                    )
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
