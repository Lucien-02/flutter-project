import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {

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