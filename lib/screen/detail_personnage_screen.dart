import 'package:comics_app/bloc/character_bloc.dart';
import 'package:comics_app/component/detail/menu_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/screen/detail/histoire_tab.dart';
import 'package:comics_app/screen/detail/info_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class DetailPersonnageScreen extends StatefulWidget {

  final String title;
  final String url;
  final String imageUrl;

  const DetailPersonnageScreen({
    super.key,
    required this.title,
    required this.url,
    required this.imageUrl,
  });

  @override
  State<DetailPersonnageScreen> createState() => _DetailPersonnageScreenState();
}

class _DetailPersonnageScreenState extends State<DetailPersonnageScreen> {


  String formatList(List<dynamic>? list) {
    if (list == null || list.isEmpty) {
      return "Pas d'infos disponibles"; // Fallback message if the list is empty or null
    }
    List<String> listNames = list.map((item) => item['name'] as String).toList();
    return "${listNames.join(', ')}";
  }

  String formatDate(String date) {
    print(date);
    try {
      //DateTime dateTime = DateTime.parse(date);
      DateTime dateTime = DateFormat('MMM d, y', 'en_US').parse(date);
      return DateFormat("d MMMM y", "fr_FR").format(dateTime);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager(dio:Dio(), baseUrl: widget.url);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return
      BlocProvider(create: (_) => CharacterBloc(apiManager)
        ..add(
            LoadCharacterEvent(
              baseUrl: widget.url,
              fieldList: 'id,description,name,real_name,aliases,creators,publisher,gender,birth',
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
                    widget.imageUrl.isNotEmpty ? widget.imageUrl : "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg",
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
                    Expanded(
                        child: BlocBuilder<CharacterBloc, CharacterState>(
                          builder: (context, CharacterState characterState) {
                            if (characterState is CharacterLoadedState ) {
                              final character = characterState.character;
                              final formattedDate = formatDate(character.birth ?? "Inconnue");

                              String gender = "";
                              if(character.gender == 1) {
                                gender = "Masculin";
                              }else if(character.gender == 2) {
                                gender = "Feminin";
                              }else if(character.gender == 3) {
                                gender = "Autres";
                              }

                              final List<Map<String, String>> cleValuePairs = [
                                {
                                  "Nom de super-héros": character.name ?? "",
                                },
                                {
                                  "Nom réel": character.realName ?? "",

                                },
                                /*{
                                  "Alias": formatList(character.aliases),
                                },*/
                                {
                                  "Editeur": character.publisher?.name ?? "",
                                },
                                {
                                  "Créateurs": formatList(character.creators),
                                },
                                {
                                  "Genre": gender,
                                },
                                {
                                  "Date de naissance": formattedDate ,
                                }
                              ];
                              // Dynamically pass tabs and screens
                              return MenuWidget(
                                length: 2,
                                tabs: [
                                  Tab(text: 'Histoire'),
                                  Tab(text: 'Infos'),
                                ],
                                screens: [
                                  HistoireTab(data: character.description ?? ""),
                                  InfoTab(cleValuePairs: cleValuePairs),
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
        ),
      );
  }
}