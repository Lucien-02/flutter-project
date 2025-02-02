import 'package:comics_app/bloc/film_bloc.dart';
import 'package:comics_app/component/detail/header_widget.dart';
import 'package:comics_app/component/detail/menu_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/screen/detail/histoire_tab.dart';
import 'package:comics_app/screen/detail/info_tab.dart';
import 'package:comics_app/screen/detail/personnage_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class DetailFilmScreen extends StatefulWidget {

  final String title;
  final String url;
  final int id;
  final String imageUrl;


  const DetailFilmScreen({
    super.key,
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
  });

  @override
  State<DetailFilmScreen> createState() => _DetailFilmScreenState();
}

class _DetailFilmScreenState extends State<DetailFilmScreen> {


  String formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat("y", "fr_FR").format(dateTime);
    } catch (e) {
      return date;
    }
  }

  String formatMoney(String amount) {
    if (amount.isEmpty) {
      return "Pas de montant existant";
    }

    String cleanAmount = amount.replaceAll(RegExp(r'[\$\s]'), '');
    if (amount.contains('million')) {
      cleanAmount = cleanAmount.replaceAll('million', '').trim();
      double number = double.parse(cleanAmount);
      double millions = number;

      return '${millions.toStringAsFixed(0)} millions \$';
    }

    int number = int.parse(cleanAmount);

    if (number >= 1000000) {
      double millions = number / 1000000;
      return '${millions.toStringAsFixed(0)} millions \$';
    }

    return '\$${number.toString()}';
  }



  String formatList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return "Pas d'infos disponibles"; // Fallback message if the list is empty or null
    }
    List<String> listNames = list.map((item) => item['name'] as String).toList();
    return "${listNames.join(', ')}";
  }

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager(dio:Dio(), baseUrl: widget.url);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return
      BlocProvider(create: (_) => FilmBloc(apiManager)
        ..add(
            LoadFilmWithCustomUrlEvent(
              baseUrl: widget.url,
              fieldList: 'id,image,name,rating,api_detail_url,release_date,description,runtime,total_revenue,date_added,writers,studios,producers,characters,budget,box_office_revenue',
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
                        BlocBuilder<FilmBloc, FilmState>(
                          builder: (context, FilmState state) {
                            if (state is FilmLoadingState) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is OneFilmLoadedState) {
                              final film = state.film;

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
                                padding: const EdgeInsets.all(16),
                                child: HeaderWidget(
                                    keyValuePairs: iconTextPairs,
                                    imageUrl: film.image?.smallUrl ?? ""),
                              );

                            } else if (state is FilmErrorState) {
                              return Center(child: Text('Error: ${state.message}',style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white)));
                            } else {
                              return Center(
                                  child: Text(
                                      'Please load the film.',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white)
                                  )
                              );
                            }

                          },
                        ),
                        Expanded(
                          child: BlocBuilder<FilmBloc, FilmState>(
                            builder: (context, FilmState filmState) {
                              if (filmState is OneFilmLoadedState ) {
                                final List<Map<String, String>> cleTextPairs = [
                                  {
                                    "Classification" :  "${filmState.film.rating ?? ''}",
                                  },
                                  /*{
                                    "Réalisateur": formattedDate,
                                  },*/
                                  {
                                    "Scénaristes": formatList(filmState.film.writers),
                                  },
                                  {
                                    "Producteurs": formatList(filmState.film.producers),
                                  },
                                  {
                                    "Studios": formatList(filmState.film.studios),
                                  },
                                  {
                                    "Budget": formatMoney(filmState.film.budget ?? ''),
                                  },
                                  {
                                    "Recettes au box-office": formatMoney(filmState.film.boxOfficeRevenue ?? ''),
                                  },
                                  {
                                    "Recettes brutes totales": formatMoney(filmState.film.totalRevenue ?? ''),
                                  },
                                ];
                                // Dynamically pass tabs and screens
                                return MenuWidget(
                                  length: 3,
                                  tabs: [
                                    Tab(text: 'Synopsis'),
                                    Tab(text: 'Personnages'),
                                    Tab(text: 'Infos'),
                                  ],
                                  screens: [
                                    HistoireTab(data: filmState.film.description ?? ""),
                                    PersonnageTab(data: filmState.film.characters ?? null ),
                                    InfoTab(cleValuePairs: cleTextPairs),

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