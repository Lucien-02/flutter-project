import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/model/series_list_response.dart';
import 'package:flutter/material.dart';

import '../component/detail/history_widget.dart';

class DemoRequestScreen extends StatelessWidget {
  const DemoRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Series List')),
      body: FutureBuilder<SeriesListResponse>(
        future: ApiManager().loadSerieListFromAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No Data'));
          } else {
            final seriesList = snapshot.data!.results;
            return ListView.builder(
              itemCount: seriesList.length,
              itemBuilder: (context, index) {
                final series = seriesList[index];
                return ListTile(
                  title: Text(series.name ?? ''),
                  subtitle: Text(series.description ?? ''),
                  leading: Image.network(series.image?.iconUrl ?? ''),
                );
              },
            );
          }
        },
      ),
    );
  }
}
