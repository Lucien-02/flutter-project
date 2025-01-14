import 'package:comics_app/bloc/comic_bloc.dart';
import 'package:comics_app/component/detail/header_widget.dart';
import 'package:comics_app/component/detail/menu_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/screen/detail/auteur_tab.dart';
import 'package:comics_app/screen/detail/histoire_tab.dart';
import 'package:comics_app/screen/detail/personnage_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class DetailComicScreen extends StatefulWidget {

  final String title;
  final String url;
  final int id;
  final String imageUrl;


  const DetailComicScreen({
    super.key,
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
  });

  @override
  State<DetailComicScreen> createState() => _DetailComicScreenState();
}

class _DetailComicScreenState extends State<DetailComicScreen> {


  String formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat("MMMM y", "fr_FR").format(dateTime);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager(dio:Dio(), baseUrl: widget.url);
    final TextTheme textTheme = Theme.of(context).textTheme;
    print(widget.id);
    return
      BlocProvider(create: (_) => ComicBloc(apiManager)
        ..add(
            LoadComicWithCustomUrlEvent(
              baseUrl: widget.url,
              fieldList: 'id,image,name,character_credits,api_detail_url,issue_number,description,person_credits,cover_date,date_added',
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
                        BlocBuilder<ComicBloc, ComicState>(
                          builder: (context, ComicState state) {
                            if (state is ComicLoadingState) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is OneComicLoadedState) {
                              final comic = state.comic;

                              final formattedDate = formatDate(comic.dateAdded ?? "");
                              final List<Map<IconData, String>> iconTextPairs = [
                                {
                                  Icons.book:  "N° ${comic.issueNumber ?? ' '}",
                                },
                                {
                                  Icons.calendar_today: formattedDate,
                                },
                              ];
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: HeaderWidget(
                                    keyValuePairs: iconTextPairs,
                                    imageUrl: comic.image?.smallUrl ?? ""),
                              );

                            } else if (state is ComicErrorState) {
                              return Center(child: Text('Error: ${state.message}',style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white)));
                            } else {
                              return Center(
                                  child: Text(
                                      'Please load the comic.',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white)
                                  )
                              );
                            }

                          },
                        ),
                        Expanded(
                          child: BlocBuilder<ComicBloc, ComicState>(
                            builder: (context, ComicState comicState) {
                              if (comicState is OneComicLoadedState ) {
                                // Dynamically pass tabs and screens
                                return MenuWidget(
                                  length: 3,
                                  tabs: [
                                    Tab(text: 'Histoire'),
                                    Tab(text: 'Auteurs'),
                                    Tab(text: 'Personnages'),
                                  ],
                                  screens: [
                                    HistoireTab(data: comicState.comic.description ?? ""),
                                    AuteurTab(data: comicState.comic.personCredits ?? null),
                                    PersonnageTab(data: comicState.comic.characterCredits ?? null ),

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