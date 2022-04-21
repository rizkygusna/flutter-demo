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

//Stateful widget, mantain state that might change
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

// State class for use with RandomWords. Immutable.
// The logic of the Widget
class _RandomWordsState extends State<RandomWords> {
  // list of WordPair
  final List<WordPair> _suggestions = generateWordPairs().take(10).toList();
  // final List<WordPair> _suggestions = [];

  // use set instead of list because saved names will be unique
  final _saved = <WordPair>{};
  // style for Text
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // favorite icon on tap handler
  void itemOnTapHandler(int index, bool isSaved) {
    setState(() {
      if (!isSaved) {
        _saved.add(_suggestions[index]);
      } else {
        _saved.remove(_suggestions[index]);
      }
    });
  }

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
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();
            // add more data if approaching end of scroll
            if (i >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            // check if the item is already saved
            final bool isAlreadySaved = _saved.contains(_suggestions[i]);
            return ListTile(
              title: Text(
                _suggestions[i].asPascalCase,
                style: _biggerFont,
              ),
              trailing: Icon(
                  isAlreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: isAlreadySaved ? Colors.red : null,
                  semanticLabel: isAlreadySaved ? 'Remove from saved' : 'Save'),
              onTap: () => itemOnTapHandler(i, isAlreadySaved),
            );
          }),
    );
  }
}
