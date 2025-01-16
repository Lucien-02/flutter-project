
import 'package:comics_app/component/horizontal_item_list_widget.dart';
import 'package:comics_app/component/item_widget.dart';
import 'package:comics_app/screen/series_tab.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  //final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {
        'imageUrl': '',
        'title': 'Série 1',
        'subtitle': 'Description 1',
      },
      {
        'imageUrl': '',
        'title': 'Série 2',
        'subtitle': 'Description 2',
      },
      {
        'imageUrl': '',
        'title': 'Série 3',
        'subtitle': 'Description 3',
      },
      {
        'imageUrl': '',
        'title': 'Série 4',
        'subtitle': 'Description 4',
      },
      {
        'imageUrl': '',
        'title': 'Série 5',
        'subtitle': 'Description 5',
      },
    ];
    return SingleChildScrollView(
  child: Column(
    spacing: 15,
    children: [
      HorizontalItemList(
        title: 'Séries populaires',
        items: items,
        onVoirPlus: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeriesTab(),
            ),
          );
        },
      ),
      HorizontalItemList(
        title: 'Comics populaires',
        items: items,
        onVoirPlus: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeriesTab(),
            ),
          );
        },
      ),
      HorizontalItemList(
        title: 'Films populaires',
        items: items,
        onVoirPlus: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeriesTab(),
            ),
          );
        },
      ),
    ],
  ),
);
  }

/*@override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (_) => SeriesCubit(apiService)..fetchSeries()),
        BlocProvider(create: (_) => ComicsCubit(apiService)..fetchComics()),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Séries populaires'),
            _buildSeriesSection(context),
            SectionTitle(title: 'Comics populaires'),
            _buildComicsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSeriesSection(BuildContext context) {
    return BlocBuilder<SeriesCubit, SeriesState>(
      builder: (context, state) {
        if (state is SeriesLoading) return Center(child: CircularProgressIndicator());
        if (state is SeriesLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.series.length,
              itemBuilder: (context, index) {
                final series = state.series[index];
                return CardItem(title: series.title, imageUrl: series.imageUrl);
              },
            ),
          );
        }
        return Center(child: Text('Erreur lors du chargement des séries.'));
      },
    );
  }

  Widget _buildComicsSection(BuildContext context) {
    return BlocBuilder<ComicsCubit, ComicsState>(
      builder: (context, state) {
        if (state is ComicsLoading) return Center(child: CircularProgressIndicator());
        if (state is ComicsLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.comics.length,
              itemBuilder: (context, index) {
                final comic = state.comics[index];
                return CardItem(title: comic.title, imageUrl: comic.imageUrl);
              },
            ),
          );
        }
        return Center(child: Text('Erreur lors du chargement des comics.'));
      },
    );
  }*/
}