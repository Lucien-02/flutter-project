import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*import '../blocs/series_bloc.dart';
import '../blocs/comics_bloc.dart';
import '../widgets/card_item.dart';
import '../widgets/section_title.dart';
import '../repositories/api_service.dart';*/

class SearchTab extends StatelessWidget {
  //final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('SelectionContainer.disabled Sample')),
        body: const Center(
          child: SelectionArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Selectable text'),
                SelectionContainer.disabled(child: Text('Non-selectable text')),
                Text('Selectable text'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}