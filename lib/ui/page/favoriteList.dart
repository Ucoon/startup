import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class FavoriteListPage extends StatefulWidget {
  final Set<WordPair> favoriteList;

  FavoriteListPage({Key key, this.favoriteList}) : super(key: key);

  @override
  createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    final titles = widget.favoriteList.map((wordPair) {
      return ListTile(
        title: Text(
          wordPair.asPascalCase,
          style: _biggerFont,
        ),
        onTap: () => Navigator.pushNamed(context, '/detail',
            arguments: wordPair.asPascalCase),
      );
    });
    final divided = ListTile.divideTiles(
      context: context,
      tiles: titles,
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}
