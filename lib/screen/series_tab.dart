import 'package:comics_app/bloc/serie_bloc.dart';
import 'package:comics_app/component/card_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesTab extends StatefulWidget {
  @override
  _SeriesTabState createState() => _SeriesTabState();
}

class _SeriesTabState extends State<SeriesTab> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SerieBloc>(context).add(LoadSerieListEvent(fieldList: 'id,image,name,publisher,count_of_episodes,start_year,api_detail_url'));
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
      final currentState = BlocProvider.of<SerieBloc>(context).state;
      print(currentState);
      if (currentState is SerieLoadedState) {
        BlocProvider.of<SerieBloc>(context).add(LoadMoreSeriesEvent(fieldList: 'id,image,name,publisher,count_of_episodes,start_year,api_detail_url'));
      }
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
            'Séries les plus populaires',
            style: textTheme.displayLarge,
          ),
        ),
        body: BlocBuilder<SerieBloc, SerieState>(
          builder: (context, SerieState state) {
            if (state is SerieLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SerieLoadedState) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.series.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.series.length) {
                    final serie = state.series[index];

                    final List<Map<IconData, String>> iconTextPairs = [
                      {
                        Icons.book: serie.publisher?.name ?? "",
                      },
                      {
                        Icons.tv: "${serie.countOfEpisodes ?? 0} Episodes",
                      },
                      {
                        Icons.calendar_today: serie.startYear ?? "",
                      },
                    ];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CardWidget(
                        id: serie.id ?? 0,
                        url: serie.apiDetailUrl ?? "",
                        name: serie.name ?? "",
                        subtitle: "",
                        keyValuePairs: iconTextPairs,
                        imageUrl: serie.image?.smallUrl ?? "",
                        rank: serie.id ?? 0,
                        type: 'serie',
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
            } else if (state is SerieErrorState) {
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
                        context.read<SerieBloc>().add(
                          LoadSerieListEvent(
                            fieldList: 'id,image,name,publisher,count_of_episodes,start_year,api_detail_url',
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
                'Veuillez charger la liste des séries.',
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
            );
          },
        ),
    );
  }
}
