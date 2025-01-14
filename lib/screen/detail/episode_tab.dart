import 'package:comics_app/bloc/episode_bloc.dart';
import 'package:comics_app/component/detail/episode_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class EpisodeTab extends StatelessWidget {
  final List<dynamic>? data;

  const EpisodeTab({required this.data, Key? key}) : super(key: key);

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
    return ListView.builder(
      padding: EdgeInsets.only(top:15,right: 15,left: 15),
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        final episode = data?[index];
       /* final formattedAirDate = formatAirDate(episode['airDate'] ?? "");
        final List<Map<IconData, String>> iconTextPairs = [
          {
            Icons.calendar_today: formattedAirDate,
          },
        ];*/

        return Padding(
          padding: const  EdgeInsets.symmetric(vertical:15.0),
          child: EpisodeWidget(
            episode_url: episode['api_detail_url'] ?? "",
           /* name: "Episode #${episode['episodeNumber']}",
            subtitle: episode['name'] ?? "",
            keyValuePairs: iconTextPairs,
            imageUrl: episode.image?.smallUrl ?? "",*/
          ),
        );
      },
    );
  }
}