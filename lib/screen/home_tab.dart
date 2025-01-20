import 'package:comics_app/bloc/tab_bloc.dart';
import 'package:comics_app/component/horizontal_item_list_widget.dart';
import 'package:comics_app/component/item_widget.dart';
import 'package:comics_app/screen/series_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comics_app/bloc/serie_bloc.dart';
import 'package:comics_app/bloc/comic_bloc.dart';
import 'package:comics_app/bloc/film_bloc.dart';
import 'package:comics_app/bloc/person_bloc.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:go_router/go_router.dart';

class HomeTab extends StatelessWidget {
  //final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => SerieBloc(apiManager)
              ..add(LoadSerieListEvent(
                fieldList: 'id,image,name,description,api_detail_url',
                limit: 5,
              ))),
        BlocProvider(
          create: (_) => ComicBloc(apiManager)
            ..add(LoadComicListEvent(
              fieldList: 'id,image,name,api_detail_url,description',
              limit: 5,
            )),
        ),
        BlocProvider(
          create: (_) => FilmBloc(apiManager)
            ..add(LoadFilmListEvent(
              fieldList: 'id,image,name,api_detail_url,description',
              limit: 5,
            )),
        ),
        BlocProvider(
          create: (_) => PersonBloc(apiManager)
            ..add(LoadPersonListEvent(
              fieldList: 'id,image,name,api_detail_url',
              limit: 5,
            )),
        )
      ],
      child: SingleChildScrollView(
        child: Column(
          //spacing: 15,
          children: [
            _buildSeriesSection(context),
            SizedBox(height: 15),
            _buildComicsSection(context),
            SizedBox(height: 15),
            _buildFilmsSection(context),
            SizedBox(height: 15),
            _buildPersonsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSeriesSection(BuildContext context) {
    return BlocBuilder<SerieBloc, SerieState>(
      builder: (context, SerieState state) {
        if (state is SerieLoadingState)
          return Center(child: CircularProgressIndicator());
        if (state is SerieLoadedState) {
          final List<Map<String, String>> items = state.series.map((serie) {
            return {
              'imageUrl': serie.image?.smallUrl ?? '',
              'title': serie.name ?? 'Unknown Title',
              'subtitle': serie.deck ?? '',
              'detail_route_name': '/serie-detail',
              'url': serie.apiDetailUrl ?? '',
              'id': '$serie.id',
            };
          }).toList();
          return HorizontalItemList(
            title: 'Séries populaires',
            items: items,
            btnVoirPlus: true,
            type: 'serie',
            onVoirPlus: () {
              BlocProvider.of<TabBloc>(context).add(SelectTabEvent(2));
              //context.go('/series');
            },
          );
        }
        return Center(child: Text('Erreur lors du chargement des séries.'));
      },
    );
  }

  Widget _buildComicsSection(BuildContext context) {
    return BlocBuilder<ComicBloc, ComicState>(
      builder: (context, ComicState state) {
        if (state is ComicLoadingState)
          return Center(child: CircularProgressIndicator());
        if (state is ComicLoadedState) {
          final List<Map<String, String>> items = state.comics.map((comic) {
            return {
              'imageUrl': comic.image?.smallUrl ?? '',
              'title': comic.name ?? 'Unknown Title',
              'subtitle': comic.deck ?? 'No Description',
              'detail_route_name': '/comic-detail',
              'url': comic.apiDetailUrl ?? '',
              'id': '$comic.id',
            };
          }).toList();
          return HorizontalItemList(
            title: 'Comics populaires',
            items: items,
            btnVoirPlus: true,
            type: 'comic',
            onVoirPlus: () {
              BlocProvider.of<TabBloc>(context).add(SelectTabEvent(1));
            },
          );
        }
        return Center(child: Text('Erreur lors du chargement des comics.'));
      },
    );
  }

  Widget _buildFilmsSection(BuildContext context) {
    return BlocBuilder<FilmBloc, FilmState>(
      builder: (context, FilmState state) {
        if (state is FilmLoadingState)
          return Center(child: CircularProgressIndicator());
        if (state is FilmLoadedState) {
          final List<Map<String, String>> items = state.films.map((film) {
            return {
              'imageUrl': film.image?.smallUrl ?? '',
              'title': film.name ?? 'Unknown Title',
              'subtitle': film.deck ?? 'No Description',
              'detail_route_name': '/film-detail',
              'url': film.apiDetailUrl ?? '',
              'id': '$film.id',
            };
          }).toList();
          return HorizontalItemList(
            title: 'Films populaires',
            items: items,
            btnVoirPlus: true,
            type: 'film',
            onVoirPlus: () {
              BlocProvider.of<TabBloc>(context).add(SelectTabEvent(3));
            },
          );
        }
        return Center(child: Text('Erreur lors du chargement des films.'));
      },
    );
  }

  Widget _buildPersonsSection(BuildContext context) {
    return BlocBuilder<PersonBloc, PersonState>(
      builder: (context, PersonState state) {
        if (state is PersonLoadingState)
          return Center(child: CircularProgressIndicator());
        if (state is PersonLoadedState) {
          final List<Map<String, String>> items = state.persons.map((person) {
            return {
              'imageUrl': person.image?.smallUrl ?? '',
              'title': person.name ?? 'Unknown Title',
              'subtitle': 'No Description',
            };
          }).toList();
          return HorizontalItemList(
            title: 'Personnages',
            items: items,
            btnVoirPlus: false,
            type: 'film',
            onVoirPlus: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeriesTab(),
                ),
              );
            },
          );
        }
        return Center(
            child: Text('Erreur lors du chargement des personnages.'));
      },
    );
  }
}
