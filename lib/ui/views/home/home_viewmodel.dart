import 'package:stacked/stacked.dart';
import 'package:english_words/english_words.dart';

class HomeViewModel extends BaseViewModel {
  final List<WordPair> _suggestions = generateWordPairs().take(10).toList();
  List<WordPair> get suggestions => _suggestions;
}
