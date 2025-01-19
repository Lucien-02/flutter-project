import 'package:comics_app/bloc/comic_bloc.dart';
import 'package:comics_app/bloc/film_bloc.dart';
import 'package:comics_app/bloc/serie_bloc.dart';
import 'package:comics_app/component/horizontal_item_list_widget.dart';
import 'package:comics_app/screen/series_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  //final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 15,
        children: [
          // BlocBuilder Séries populaires
          BlocBuilder<SerieBloc, SerieState>(
            builder: (context, state) {
              if (state is SerieLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SerieLoadedState) {
                final popularSeries = state.series.take(5).map((serie) {
                  return {
                    'imageUrl': serie.image?.smallUrl ?? '',
                    'title': serie.name ?? 'Inconnu',
                    'subtitle': '',
                  };
                }).toList();
                return HorizontalItemList(
                  title: 'Séries populaires',
                  items: popularSeries,
                  btnVoirPlus: true,
                  onVoirPlus: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriesTab(),
                      ),
                    );
                  },
                );
              } else if (state is SerieErrorState) {
                return Text(
                  'Erreur : ${state.message}',
                  style: const TextStyle(fontSize: 11, color: Colors.white),
                  textAlign: TextAlign.center,
                );
              }
              return const Center(
                child: Text(
                  'Veuillez charger des données.',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              );
            },
          ),
          BlocBuilder<ComicBloc, ComicState>(
            builder: (context, state) {
              if (state is ComicLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ComicLoadedState) {
                final popularComics = state.comics.take(5).map((serie) {
                  return {
                    'imageUrl': serie.image?.smallUrl ?? '',
                    'title': serie.name ?? 'Inconnu',
                    'subtitle': '',
                  };
                }).toList();
                return HorizontalItemList(
                  title: 'Comics populaires',
                  items: popularComics,
                  btnVoirPlus: true,
                  onVoirPlus: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriesTab(),
                      ),
                    );
                  },
                );
              } else if (state is ComicErrorState) {
                return Text(
                  'Erreur : ${state.message}',
                  style: const TextStyle(fontSize: 11, color: Colors.white),
                  textAlign: TextAlign.center,
                );
              }
              return const Center(
                child: Text(
                  'Veuillez charger des données.',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              );
            },
          ),
          BlocBuilder<FilmBloc, FilmState>(
            builder: (context, state) {
              if (state is FilmLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FilmLoadedState) {
                final popularFilms = state.films.take(5).map((serie) {
                  return {
                    'imageUrl': serie.image?.smallUrl ?? '',
                    'title': serie.name ?? 'Inconnu',
                    'subtitle': '',
                  };
                }).toList();
                return HorizontalItemList(
                  title: 'Films populaires',
                  items: popularFilms,
                  btnVoirPlus: true,
                  onVoirPlus: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriesTab(),
                      ),
                    );
                  },
                );
              } else if (state is FilmErrorState) {
                return Text(
                  'Erreur : ${state.message}',
                  style: const TextStyle(fontSize: 11, color: Colors.white),
                  textAlign: TextAlign.center,
                );
              }
              return const Center(
                child: Text(
                  'Veuillez charger des données.',
                  style: TextStyle(fontSize: 11, color: Colors.white),
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
