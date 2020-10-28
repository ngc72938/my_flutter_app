import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'bloc/bloc.dart';

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("saved")),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    // ignore: missing_return
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          var saved = Set<WordPair>();

          if (snapshot.hasData)
            saved.addAll(snapshot.data);
          else
            bloc.addCurrentSaved;

          return ListView.builder(
              itemCount: saved.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd) return Divider();
                print(index);
                var realIndex = index ~/ 2;
                return _buildRow(saved.toList()[realIndex]);
              });
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(pair,null);
      },
    );
  }
}
