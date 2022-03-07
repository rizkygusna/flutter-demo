// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      // render the stateful widget
      home: const RandomWords(),
    );
  }
}

// State class for use with RandomWords. Immutable.
// The logic of the Widget
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  // use set instead of list because saved names will be unique
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);

  void _pushSaved() {
    // push the route to the Navigator's stack
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) {
        final tiles = _saved.map(
          (pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );

        // create list of tiles
        // use late because this variable might not be needed
        late final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        if (tiles.isEmpty) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Saved Suggestions'),
              ),
              body: Center(
                child: Text(
                  "Saved suggestion is empty",
                  style: _biggerFont,
                ),
              ));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        // add actions in AppBar
        actions: [
          // add one button in action list
          IconButton(
            // call the handler function
            onPressed: _pushSaved,
            icon: const Icon(Icons.format_list_bulleted),
            tooltip: 'Saved Suggestion',
          ),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          // will be called only with indices greater than or equal to zero
          itemBuilder: (context, i) {
            // add devider if the i is odd
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            // if the scroll is near end
            if (index >= _suggestions.length) {
              // append the suggestion by 10
              _suggestions.addAll(generateWordPairs().take(10));
            }
            // check if the entry is already saved or not
            final bool alreadySaved = _saved.contains(_suggestions[index]);
            // render the name row
            return ListTile(
              title: Text(
                _suggestions[index].asPascalCase,
                style: _biggerFont,
              ),
              // render the icon based on the alreadySaved or not
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
                semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
              ),
              // on tap handler
              onTap: () {
                // setState() triggers a call to the build()
                setState(() {
                  if (alreadySaved) {
                    _saved.remove(_suggestions[index]);
                  } else {
                    _saved.add(_suggestions[index]);
                  }
                });
              },
            );
          }),
    );
  }
}

//Stateful widget, mantain state that might change
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}
