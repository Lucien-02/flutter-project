
import 'package:comics_app/component/item_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  //final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Center(
            child: 
            // Text(
            //   'Contenu de la section Films',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
            // ),
            Column(
              children: [
                ItemWidget(imageUrl: 'https://www.carrementfleurs.com/modules/prestablog/views/img/grid-for-1-7/up-img/86.jpg', title: "title", subtitle: "testqrgqergqergqertgrtg",)
              ],
            )
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