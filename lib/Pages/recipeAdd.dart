import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../main.dart';

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
  File _image;
  var isProgressActive = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController imgUrl = new TextEditingController();

  // Future<List> submitRecipe() async {
  //   final response = await http.post('http://192.168.0.100/api/submitRecipe',
  //       body: {
  //         'title': title.text,
  //         'description': description.text,
  //       });
  //   respond = json.decode(response.body);
  //   print(respond);

  //   if (respond['errorCode'] == 0) {
  //     setState(() {
  //       print('Data Entered Successfully !!!');
  //       title.text = '';
  //       description.text = '';
  //       showInSnackBar('Data Entered Successfully');
  //     });
  //   } else {
  //     setState(() {
  //       print('Server Down!!!');
  //       showInSnackBar('Something Went Wrong !!! Try Again ');
  //     });
  //   }
  // }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future _uploadData() async {
    setState(() {
      isProgressActive = true;
    });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        isProgressActive = false;
      });
    });

    final length = await _image.length();
    var url = Uri.parse('http://api.webforeveryone.tech/api/submitRecipe');
    var request = new http.MultipartRequest("POST", url);
    request.fields['title'] = title.text;
    request.fields['description'] = description.text;
    print(_image);
    var stream = new ByteStream(DelegatingStream.typed(_image.openRead()));
    request.files.add(
      new http.MultipartFile('user_photo', stream, length,
          contentType: new MediaType('image', 'jpeg'),
          filename: basename(_image.path)),
    );
    print(request.fields);
    print(request.files);

    request.send().then((response) {
      print(response);
      if (response.statusCode == 200) {
        print('uploaded');
        isProgressActive = false;
        title.text = '';
        description.text = '';
        _image = null;
        showInSnackBar("Uploaded Successfully !!!");
      } else {
        print('upload failed');
        print(response.statusCode);
        showInSnackBar("Something Went Wrong !!!");
      }
    });
  }

  // Future getUploadImg() async {
  //   print('upload clicked');
  //   String apiUrl = 'http://api.webforeveryone.tech/api/submitRecipe';
  //   final length = await _image.length();
  //   final request = new http.MultipartRequest('POST', Uri.parse(apiUrl));
  //   request.fields['title'] = title.text;
  //   request.fields['description'] = description.text;
  //   print(request.toString());

  //   request.files
  //       .add(new http.MultipartFile('user_photo', _image.openRead(), length));
  //   request.headers[HttpHeaders.CONTENT_TYPE] = 'multipart/form-data';

  //   // http.Response response =
  //   //     await http.Response.fromStream(await request.send());
  //   //     respond = json.decode(response.body);
  //   // print(respond);
  //   request.send();

  //   // if (respond['errorCode'] == 0) {
  //   //   setState(() {
  //   //     print('Data Entered Successfully !!!');
  //   //     title.text = '';
  //   //     description.text = '';
  //   // });
  //   // } else {
  //   //   setState(() {
  //   //     print('Server Down!!!');
  //   //   });
  //   // }
  //   // print("Result: ${response.body}");
  //   // return json.decode(response.body);
  // }

  Widget buildv() {
    if (isProgressActive) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new Center(
        child: Builder(
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
                      onTap: () {
                        getImage();
                        print('gesture recorderd !!!');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 50.0),
                        child: _image == null
                            ? Image.asset('assets/logo.png',
                                height: 80.0, width: 80.0)
                            : Image.file(
                                _image,
                                height: 120.0,
                                width: 120.0,
                                fit: BoxFit.contain,
                              ),
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

                    // RaisedButton(
                    //   child: Text('Submit'),
                    //   color: Colors.white,
                    //   elevation: 4.0,
                    //   onPressed: () {
                    //     _uploadData();
                    //     print('Onpressed clicked');
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (BuildContext context) => HomePage(),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
        ),
      );
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(5.0),
          child: RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              _uploadData();
              print('Onpressed clicked');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
              );
            },
          ),
        ),
        body: buildv(),
      ),
    );
  }
}
