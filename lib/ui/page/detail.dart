import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String detail;

  DetailPage({Key key, this.detail}) : super(key: key);

  @override
  createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Text(widget.detail),
      ),
    );
  }
}
