import 'package:comics_app/bloc/episode_bloc.dart';
import 'package:comics_app/component/detail/episode_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class EpisodeTab extends StatelessWidget {
  final int serieId;

  const EpisodeTab({required this.serieId, Key? key}) : super(key: key);

  String formatAirDate(String airDate) {
    try {
      DateTime dateTime = DateTime.parse(airDate);
      return DateFormat("d MMMM y", "fr_FR").format(dateTime);
    } catch (e) {
      return airDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager();

    return BlocProvider(
      create: (context) => EpisodeBloc(apiManager)
        ..add(
          LoadEpisodeBySerieEvent(
            baseUrl: 'https://comicvine.gamespot.com/api/episodes/',
            fieldList: 'id,image,name,air_date,episode_number',
            filter: 'series.id:${serieId}',
          ),
        ),
      child: BlocBuilder<EpisodeBloc, EpisodeState>(
        builder: (context, EpisodeState state) {
          if (state is EpisodeLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EpisodeLoadedState) {
            return ListView.builder(
              padding: EdgeInsets.only(top:15,right: 15,left: 15),
              itemCount: state.episodes.length,
              itemBuilder: (context, index) {
                final episode = state.episodes[index];
                final formattedAirDate = formatAirDate(episode.airDate ?? "");
                final List<Map<IconData, String>> iconTextPairs = [
                  {
                    Icons.calendar_today: formattedAirDate,
                  },
                ];

                return Padding(
                  padding: const  EdgeInsets.symmetric(vertical:15.0),
                  child: EpisodeWidget(
                    id: episode.id ?? 0,
                    name: "Episode #${episode.episodeNumber}",
                    subtitle: episode.name ?? "",
                    keyValuePairs: iconTextPairs,
                    imageUrl: episode.image?.smallUrl ?? "",
                  ),
                );
              },
            );
          } else if (state is EpisodeErrorState) {
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
    );
  }
}