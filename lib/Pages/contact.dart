import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreatePageState();
  }
}

class CreatePageState extends State<ContactPage> {
  _launchURL() async {
    const url = 'mailto:codingguru007@gmail.com?subject=Help&body=Ask You Doubt here';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
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
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Contact Us',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                    SizedBox(height: 15.0),
                    Text('This app is completely for educational purpose'),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: _launchURL,
                        child:Text(
                        'Email id : abc@gmail.com',
                        style: TextStyle(
                          color: Colors.blue,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            wordSpacing: 4.0),
                        textAlign: TextAlign.center,
                      ),),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'This app is built for as a project for Ty. B.Sc Computer Science SEM V',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          wordSpacing: 2.0,
                          color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
