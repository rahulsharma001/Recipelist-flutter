import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  String title;
  String description;
  String imageUrl;

  DetailPage(this.title, this.description, this.imageUrl);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 100.0),
              height: 170.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.imageUrl),
                  )),
              // child: Image.network(
              //   widget.imageUrl,
              //   fit: BoxFit.contain,
              // ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(widget.description),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
