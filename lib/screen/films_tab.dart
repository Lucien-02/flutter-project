import 'package:comics_app/bloc/film_bloc.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:comics_app/component/card_widget.dart';
import 'package:comics_app/theme/app_colors.dart';


class FilmsTab extends StatefulWidget {
  @override
  _FilmsTabState createState() => _FilmsTabState();
}

class _FilmsTabState extends State<FilmsTab> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<FilmBloc>(context).add(LoadFilmListEvent(fieldList: 'id,image,name,runtime,api_detail_url,date_added'));
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent -100 &&
        !_scrollController.position.outOfRange) {
      final currentState = BlocProvider.of<FilmBloc>(context).state;
      if (currentState is FilmLoadedState) {
        BlocProvider.of<FilmBloc>(context).add(LoadMoreFilmsEvent(fieldList: 'id,image,name,runtime,api_detail_url,date_added'));
      }
    }
  }

  String formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat("y", "fr_FR").format(dateTime);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundScreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Films les plus populaires',
          style: textTheme.displayLarge,
        ),
      ),
      body: BlocBuilder<FilmBloc, FilmState>(
        builder: (context, FilmState state) {
          if (state is FilmLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FilmLoadedState) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.films.length + 1,
              itemBuilder: (context, index) {
                if (index < state.films.length) {
                  final film = state.films[index];
                  final formattedDate = formatDate(film.dateAdded ?? "");
                  final List<Map<IconData, String>> iconTextPairs = [
                    {
                      Icons.book:  "${film.runtime ?? ' '} minutes",
                    },
                    {
                      Icons.calendar_today: formattedDate,
                    },
                  ];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CardWidget(
                      id: film.id ?? 0,
                      url: film.apiDetailUrl ?? "",
                      name: film.name ?? "",
                      subtitle: "",
                      keyValuePairs: iconTextPairs,
                      imageUrl: film.image?.smallUrl ?? "",
                      rank: film.id ?? 0,
                      type: 'film',
                    ),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          } else if (state is FilmErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Erreur : ${state.message}',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FilmBloc>().add(
                        LoadFilmListEvent(
                          fieldList: 'id,image,name,runtime,api_detail_url',
                          limit: 50,
                        ),
                      );
                    },
                    child: Text('Réessayer'),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              'Veuillez charger la liste des films.',
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
