import 'dart:async';

import 'package:flutter/material.dart';
import './Pages/recipeAdd.dart';
import 'package:RecipeList/FactoryClass/FetchData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Pages/details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.purpleAccent,
        buttonColor: Colors.blue,
      ),
      routes: {
        '/second': (context) => RecipeAdd(),
        // 'details':(context) => DetailPage(),
      },
      home: HomePage(),
    );
  }
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
  Set<FetchData> _saved = new Set<FetchData>();
  var isLoading = false;

  Future<FetchData> _fetchData() async {
    // setState(() {
    //   isLoading = true;
    // });

    final response =
        await http.get("http://api.webforeveryone.tech/api/submitRecipe");
    print(response.statusCode);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new FetchData.fromJson(data))
          .toList();
      // setState(() {
      //   isLoading = false;
      // });
    } else {
      throw Exception('Failed to load photos');
    }
    print(json.decode(response.body));
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   this._fetchData();
  // }
  void _push() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map((FetchData data) {
            return new ListTile(
title: Text(data.title),
            );
      
          });
           final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();

            return new Scaffold(         // Add 6 lines from here...
          appBar: new AppBar(
            title: const Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided),
        );   
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool alreadySaved = _saved.contains(list);

    // TODO: implement build
    return Builder(
      builder: (BuildContext context) => Scaffold(
            backgroundColor: Color.fromRGBO(237, 232, 232, 1.0),
            floatingActionButton: FloatingActionButton(
              elevation: 5.0,
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
            ),
            appBar: AppBar(
              title: Text('Recipe List'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () {
                    _push;
                  },
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                      child: Text(
                        'This Is Drawer Header',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.fastfood,
                      color: Colors.red,
                    ),
                    title: Text('Add Recipes'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/second');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.red),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: FutureBuilder(
              future: _fetchData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 20.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            DetailPage(
                                                list[index].title,
                                                list[index].description,
                                                list[index].imageUrl),
                                      ),
                                    );
                                  },
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
                                    onTap: () {
                                      setState(() {
                                        if (alreadySaved)
                                          _saved.remove(list[index]);
                                        else
                                          _saved.add(list[index]);
                                      });
                                      print('fav clicked');
                                    },
                                    child: Container(
                                      child: Icon(
                                        alreadySaved
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: alreadySaved ? Colors.red : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                }
              },
            ),
          ),
    );
  }

  _fetchDatas() async {
    await Future.delayed(Duration(seconds: 2));
    return 'REMOTE DATAs';
  }
}
