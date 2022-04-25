import 'package:stacked/stacked.dart';
import 'package:english_words/english_words.dart';

class SavedViewModel extends BaseViewModel {
  final _title = 'Saved Suggestions';
  final _savedSuggestions = <WordPair>{};

  String get title => _title;
  Set<WordPair> get savedSuggestions => _savedSuggestions;
}
