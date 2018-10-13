import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import './Pages/recipeAdd.dart';
import 'package:RecipeList/FactoryClass/FetchData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Pages/details.dart';
import './Pages/about.dart';

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
        '/about':(context)=>AboutPage(),
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
  Future _list;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _list = _fetchData();
  }

  Widget _buildRow(FetchData pair) {
    final bool alreadySaved = _saved.contains(pair);

    return new ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                DetailPage(pair.title, pair.description, pair.imageUrl),
          ),
        );
      },
      contentPadding: EdgeInsets.all(10.0),
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Image.network(
            pair.imageUrl,
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          )),
      title: Text(pair.title),
      subtitle: Text(pair.description),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
        child: Container(
          child: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : Colors.red
          ),
        ),
      ),
    );
  }

  void _push() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<Container> tiles = _saved.map(
            (FetchData data) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Card(
                  elevation: 20.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetailPage(
                              data.title, data.description, data.imageUrl),
                        ),
                      );
                    },
                    contentPadding: EdgeInsets.all(10.0),
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          data.imageUrl,
                          height: 80.0,
                          width: 80.0,
                          fit: BoxFit.cover,
                        )),
                    title: Text(data.title),
                    subtitle: Text(data.description),
                  ),
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
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
                    _push();
                  },
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                      child:ListView(children: <Widget>[
                        Image.asset('assets/recipe_256.png',fit: BoxFit.fitHeight,),
                      ],)
                     
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
                    leading: Icon(Icons.info, color: Colors.red),
                    title: Text('About'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/about');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.contacts,color: Colors.red),
                    title: Text('Contact Us'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.red),
                    title: Text('Exit'),
                    onTap: () {
                      Navigator.pop(context);
                      exit(0);
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
                              children: <Widget>[_buildRow(list[index])],
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
