import 'package:comics_app/bloc/episode_bloc.dart';
import 'package:comics_app/bloc/serie_bloc.dart';
import 'package:comics_app/component/detail/header_widget.dart';
import 'package:comics_app/component/detail/menu_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/screen/serie_detail/episode_tab.dart';
import 'package:comics_app/screen/serie_detail/histoire_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';


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

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SerieBloc(apiManager)
          ..add(
              LoadSeriesWithCustomUrlEvent(
                baseUrl: widget.url,
                fieldList: 'id,image,name,publisher,count_of_episodes,start_year,api_detail_url,description',
              )
          )
        ),
       BlocProvider(create: (_) => EpisodeBloc(apiManager)
          ..add(
              LoadEpisodeBySerieEvent(
                baseUrl: 'https://comicvine.gamespot.com/api/episodes/',
                fieldList: 'id,image,name,episode_number,date_added,api_detail_url',
                filter: 'series.id:${widget.id}',
              )
          )
       ),
      ],
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
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        body:Stack(
          children: [
              Positioned.fill(
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
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
                                padding: const EdgeInsets.all(16.0),
                                child: HeaderWidget(
                                    keyValuePairs: iconTextPairs,
                                    imageUrl: serie.image?.smallUrl ?? ""),
                              );

                        } else if (state is SerieErrorState) {
                          return Center(child: Text('Error: ${state.error.toString()}',style: TextStyle(
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
                          return BlocBuilder<EpisodeBloc, EpisodeState>(
                            builder: (context, episodeState) {
                              if (serieState is OneSerieLoadedState && episodeState is EpisodeLoadedState) {
                                print(serieState.serie.description);
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
                                    EpisodeTab(data: 'personnages'),
                                    EpisodeTab(data: 'personnages'),
                                  ],
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          );
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