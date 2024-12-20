import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*import '../blocs/series_bloc.dart';
import '../blocs/comics_bloc.dart';
import '../widgets/card_item.dart';
import '../widgets/section_title.dart';
import '../repositories/api_service.dart';*/

class HomeTab extends StatelessWidget {
  //final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Contenu de la section Films',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
        ),
      ],
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