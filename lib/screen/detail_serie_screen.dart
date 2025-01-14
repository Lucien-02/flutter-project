import 'package:comics_app/bloc/character_bloc.dart';
import 'package:comics_app/bloc/episode_bloc.dart';
import 'package:comics_app/bloc/serie_bloc.dart';
import 'package:comics_app/component/detail/header_widget.dart';
import 'package:comics_app/component/detail/menu_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/screen/detail/episode_tab.dart';
import 'package:comics_app/screen/detail/histoire_tab.dart';
import 'package:comics_app/screen/detail/personnage_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DetailSerieScreen extends StatefulWidget {

  final String title;
  final String url;
  final int id;
  final String imageUrl;


  const DetailSerieScreen({
    super.key,
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
  });

  @override
  State<DetailSerieScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailSerieScreen> {


  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager(dio:Dio(), baseUrl: widget.url);
    final TextTheme textTheme = Theme.of(context).textTheme;
    print(widget.id);
    return
      BlocProvider(create: (_) => SerieBloc(apiManager)
            ..add(
                LoadSeriesWithCustomUrlEvent(
                  baseUrl: widget.url,
                  fieldList: 'id,image,name,publisher,count_of_episodes,start_year,api_detail_url,description,characters,episodes',
                )
            ),

        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar:  AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_outlined,color:  Colors.white),
                  onPressed: () { Navigator.pop(context); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: Text(
                widget.title,
                style: textTheme.headlineMedium
            ),
          ),
          body:Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    width: 94.87,
                    height: 127,
                    errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.6), // Adjust transparency here
                  ),
                ),
                Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                      BlocBuilder<SerieBloc, SerieState>(
                        builder: (context, SerieState state) {
                          if (state is SerieLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is OneSerieLoadedState) {
                            final serie = state.serie;

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
                              padding: const EdgeInsets.all(16),
                              child: HeaderWidget(
                                  keyValuePairs: iconTextPairs,
                                  imageUrl: serie.image?.smallUrl ?? ""),
                            );

                          } else if (state is SerieErrorState) {
                            return Center(child: Text('Error: ${state.message}',style: TextStyle(
                                fontSize: 11,
                                color: Colors.white)));
                          } else {
                            return Center(
                                child: Text(
                                    'Please load the serie.',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white)
                                )
                            );
                          }

                        },
                      ),
                      Expanded(
                        child: BlocBuilder<SerieBloc, SerieState>(
                          builder: (context, SerieState serieState) {
                                if (serieState is OneSerieLoadedState ) {
                                  // Dynamically pass tabs and screens
                                  return MenuWidget(
                                    length: 3,
                                    tabs: [
                                      Tab(text: 'Histoire'),
                                      Tab(text: 'Personnages'),
                                      Tab(text: 'Episodes'),
                                    ],
                                    screens: [
                                      HistoireTab(data: serieState.serie.description ?? 'histoire'),
                                      PersonnageTab(data: serieState.serie.characters ?? null ),
                                      EpisodeTab(data: serieState.serie.episodes ?? null),
                                    ],
                                  );
                                } else {
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                        ),
                    ]
                )
              ]
          ),
        )
    );
  }
}