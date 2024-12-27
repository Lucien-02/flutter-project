import 'package:comics_app/bloc/serie_bloc.dart';
import 'package:comics_app/component/card_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => SerieBloc(apiManager)
        ..add(
          LoadSerieListEvent(
            fieldList: 'id,image,name,publisher,count_of_episodes,start_year,api_detail_url',
            //limit: 5,
          ),
        ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundScreen,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title:  Text(
            'Séries les plus populaires ',
            style: textTheme.displayLarge,
          ),
        ),
        body: BlocBuilder<SerieBloc, SerieState>(
          builder: (context, SerieState state) {
            if (state is SerieLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SerieLoadedState) {
              return ListView.builder(
                itemCount: state.series.length,
                itemBuilder: (context, index) {
                  final serie = state.series[index];
                  // Construct iconTextPairs
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
                    padding: const  EdgeInsets.symmetric(vertical:8.0),
                    child: CardWidget(
                      id: serie.id ?? 0,
                      url: serie.apiDetailUrl ?? "",
                      name: serie.name ?? "",
                      subtitle: "",
                      keyValuePairs: iconTextPairs,
                      imageUrl: serie.image?.smallUrl ?? "",
                      rank:serie?.id ?? 0,
                      type:'serie',

                    ),
                  );
                },
              );
            } else if (state is SerieErrorState) {
              return Center(child: Text('Error: ${state.message}',style: TextStyle(
                  fontSize: 11,
                  color: Colors.white)));
            }
            return Center(
                child: Text(
                    'Please load the series list.',
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.white)
                )
            );
          },
        ),
      ),
    );
  }
}