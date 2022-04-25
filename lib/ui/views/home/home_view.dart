import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:english_words/english_words.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Startup Name Generator'),
                // add actions in AppBar
              ),
              body: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, i) {
                    if (i.isOdd) return const Divider();
                    // add more data if approaching end of scroll
                    if (i >= model.suggestions.length) {
                      model.suggestions.addAll(generateWordPairs().take(10));
                    }
                    return ListTile(
                      title: Text(
                        model.suggestions[i].asPascalCase,
                        style: _biggerFont,
                      ),
                    );
                  }),
            ));
  }
}
