import 'dart:async';

import 'package:flutter/material.dart';
import './Pages/recipeAdd.dart';
import 'package:RecipeList/FactoryClass/FetchData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<FetchData> list = List();
  var isLoading = false;

  Future<FetchData> _fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response =
        await http.get("http://api.webforeveryone.tech/api/submitRecipe");
    print(response.statusCode);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new FetchData.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      routes: {
        '/second': (context) => MyApp(),
      },
      home: Builder(
        builder: (context) => Scaffold(
              floatingActionButton: FloatingActionButton(
                elevation: 5.0,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
              appBar: AppBar(
                title: Text('Recipe List'),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: new Text("Fetch Data"),
                  onPressed: _fetchData,
                ),
              ),
              body: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        // return ListTile(
                        //   contentPadding: EdgeInsets.all(10.0),
                        //   title: new Text(list[index].title),
                        //   trailing: new Image.network(
                        //     list[index].imageUrl,
                        //     fit: BoxFit.cover,
                        //     height: 40.0,
                        //     width: 40.0,
                        //   ),
                        // );

                        return Container(
                          padding: EdgeInsets.all(10.0),
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  contentPadding: EdgeInsets.all(10.0),
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.network(
                                        list[index].imageUrl,
                                        height: 80.0,
                                        width: 80.0,
                                        fit: BoxFit.cover,
                                      )),
                                  title: Text(list[index].title),
                                  subtitle: Text(list[index].description),
                                  trailing: GestureDetector(
                                    onTap:(){
                                      print('edit clicked');
                                    },
                                    child: Container(
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
      ),
    );
  }
}
