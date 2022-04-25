import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'saved_viewmodel.dart';

class SavedView extends StatelessWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SavedViewModel>.reactive(
        viewModelBuilder: () => SavedViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(title: Text(model.title)),
            ));
  }
}
