import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:startup/ui/widget/meeting_toast_view.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to flutter'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.pushNamed(context, '/route/favorite', arguments: _saved);
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          //语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整）
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            MeetingToastViewHelper.show(context, "取消收藏");
            _saved.remove(wordPair);
          } else {
            MeetingToastViewHelper.show(context, "已收藏");
            _saved.add(wordPair);
          }
        });
      },
    );
  }
}
