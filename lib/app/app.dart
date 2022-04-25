import 'package:stacked/stacked_annotations.dart'; // for routing
import 'package:flutter_demo/ui/views/home/home_view.dart';
import 'package:flutter_demo/ui/views/saved/saved_view.dart';

// Run this command below to generate route names in app.router.dart file
// flutter pub run build_runner build --delete-conflicting-outputs

@StackedApp(routes: [
  // list all view classes in here
  MaterialRoute(page: HomeView, initial: true),
  MaterialRoute(page: SavedView)
])
class App {}
