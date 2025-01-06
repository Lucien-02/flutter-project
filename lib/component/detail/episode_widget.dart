import 'package:comics_app/bloc/episode_bloc.dart';
import 'package:comics_app/component/icon_text_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EpisodeWidget extends StatelessWidget {
  final String episode_url;

  const EpisodeWidget({
    Key? key,
    required this.episode_url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final apiManager = ApiManager();

    String formatAirDate(String airDate) {
      try {
        DateTime dateTime = DateTime.parse(airDate);
        return DateFormat("d MMMM y", "fr_FR").format(dateTime);
      } catch (e) {
        return airDate;
      }
    }

    return BlocProvider(
        create: (context) => EpisodeBloc(apiManager)
      ..add(
        LoadEpisodeEvent(
          baseUrl: episode_url,
          fieldList: 'id,image,name,api_detail_url,episode_number,air_date',
        ),
      ),
      child:Card(
        color: AppColors.cardElementBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(
            width: 344,
            height: 129,
            child: BlocBuilder<EpisodeBloc, EpisodeState>(
              builder: (context, EpisodeState state) {
                if (state is EpisodeLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is EpisodeLoadedState) {
                    final episode = state.episode;

                    if(episode !=null) {
                      final formattedAirDate = formatAirDate(episode.airDate ?? "");
                      //print(formattedAirDate);
                      final List<Map<IconData, String>> iconTextPairs = [
                        {
                          Icons.calendar_today: formattedAirDate,
                        },
                      ];

                      return  Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              episode.image?.smallUrl?.isNotEmpty ?? false
                                  ?  episode.image?.smallUrl ??
                                  "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg"
                                  : "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg",
                              width: 126,
                              height: 105,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 11),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    'Episode #${episode.episodeNumber}',
                                    style: textTheme.headlineMedium,
                                  ),
                                  // Subtitle
                                  Text(
                                    episode.name ?? "",
                                    style: textTheme.labelMedium,
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: iconTextPairs.map((pair) {
                                      return Row(
                                        children: [
                                          IconTextRow(icon: Icons.calendar_today, text: formattedAirDate),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Erreur : Episode non existant',
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      );
                    }
                } else if (state is EpisodeErrorState) {
                  return Center(
                    child: Text(
                    'Erreur : ${state.message}',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                    );
                } else {
                  return Center(
                    child: Text(
                    'Veuillez charger la série.',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
