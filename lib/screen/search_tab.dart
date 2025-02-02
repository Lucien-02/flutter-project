import 'package:comics_app/bloc/search_bloc.dart';
import 'package:comics_app/component/horizontal_item_list_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/model/comic_response.dart';
import 'package:comics_app/model/film_response.dart';
import 'package:comics_app/model/person_response.dart';
import 'package:comics_app/model/serie_response.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 163,
            decoration:  BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(35),
              ),
            ),
            padding:  EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recherche',
                  style: textTheme.displayLarge,
                ),
                 SizedBox(height: 16),
                TextField(
                  onChanged: (query) {
                    if (query.isEmpty) {
                      searchBloc.add(ResetSearchEvent());
                    }
                  },
                  onSubmitted: (query) {
                    if(query.isNotEmpty) {
                      searchBloc.add(LoadSearchListEvent(query:query ,fieldList:"id,name,image,api_detail_url"));
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Comic, film, série...',
                    hintStyle: TextStyle(fontSize: 17.0, color: Colors.white.withOpacity(0.5)),
                    suffixIcon:  Icon(Icons.search),
                    fillColor: AppColors.bottomBarBackground,
                    focusColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
           SizedBox(height: 40),
          Expanded
            (
            child: BlocBuilder<SearchBloc,SearchState>(
              builder: (context, SearchState state) {
                if (state is SearchInitialState) {
                  return Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Card container
                        Container(
                          width: 348,
                          height: 131,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 199,
                                child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(text:'Saisissez une recherche pour trouver un ',style: TextStyle(color: Colors.blue, fontSize: 15)),
                                    TextSpan(text: 'comics', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                                    TextSpan(text: ', ',style: TextStyle(color: Colors.blue, fontSize: 15)),
                                    TextSpan(text: 'film', style: TextStyle(color: Colors.blue)),
                                    TextSpan(text: ', ',style: TextStyle(color: Colors.blue, fontSize: 15)),
                                    TextSpan(text: 'série', style: TextStyle(color: Colors.blue)),
                                    TextSpan(text: ' ou ',style: TextStyle(color: Colors.blue, fontSize: 15)),
                                    TextSpan(text: 'personnage', style: TextStyle(color: Colors.blue)),
                                    TextSpan(text: '.',style: TextStyle(color: Colors.blue, fontSize: 15)),
                                  ],
                                ),
                              ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -30,
                          right: 5,
                          child: Container(
                            height: 80,
                            width: 80,
                            child: SvgPicture.asset(
                              'assets/icons/astronaut.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is SearchLoadingState) {
                    return Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 348,
                              height: 131,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:AppColors.cardBackground, // Dark background color
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 199,
                                    child: Text(
                                      'Recherche en cours.\nMerci de patienter...',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.blue, fontSize: 15),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Positioned(
                              top: -120,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: 150,
                                width: 150,
                                child: SvgPicture.asset(
                                  'assets/icons/astronaut.svg', // Replace with your SVG file path
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                } else if (state is SearchLoadedState) {
                  return SingleChildScrollView(
                    child: Column(
                      //spacing: 15,
                      children: [
                        _buildSeriesSection(context,state.series),
                        SizedBox(height: 15),
                        _buildComicsSection(context,state.comics),
                        SizedBox(height: 15),
                        _buildFilmsSection(context,state.films),
                        SizedBox(height: 15),
                        _buildPersonsSection(context,state.characters),
                      ],
                    ),
                  );
                }
                return  SizedBox.shrink();
              }
            )
          ),
        ],
      ),
    );
  }


  Widget _buildSeriesSection(BuildContext context,List<SerieResponse> series) {
    if(series.isEmpty) {
      return  _buildDefaultSection(context,'Séries');
    } else {
      final List<Map<String, String>> items = series.map((serie) {
        return {
          'imageUrl': serie.image?.smallUrl ?? '',
          'title': serie.name ?? '',
          'detail_route_name': '/serie-detail',
          'url': serie.apiDetailUrl ?? '',
          'id': '$serie.id',
        };
      }).toList();
      return HorizontalItemList(
        title: 'Séries',
        items: items,
        btnVoirPlus: false,
        type: 'serie',
      );
    }
  }

  Widget _buildComicsSection(BuildContext context, List<ComicResponse> comics) {
    if(comics.isEmpty) {
      return  _buildDefaultSection(context,'Comics');
    } else {
        final List<Map<String, String>> items = comics.map((comic) {
          return {
            'imageUrl': comic.image?.smallUrl ?? '',
            'title': comic.formattedName,
            'detail_route_name': '/comic-detail',
            'url': comic.apiDetailUrl ?? '',
            'id': '$comic.id',
          };
        }).toList();
        return HorizontalItemList(
          title: 'Comics',
          items: items,
          btnVoirPlus: false,
          type: 'comic',
        );
      }
    }

  Widget _buildFilmsSection(BuildContext context,List<FilmResponse> films) {
    if(films.isEmpty) {
      return  _buildDefaultSection(context,'Films');
    } else {
      final List<Map<String, String>> items = films.map((film) {
        return {
          'imageUrl': film.image?.smallUrl ?? '',
          'title': film.name ?? 'Unknown Title',
          'detail_route_name': '/film-detail',
          'url': film.apiDetailUrl ?? '',
          'id': '$film.id',
        };
      }).toList();
      return HorizontalItemList(
        title: 'Films',
        items: items,
        btnVoirPlus: false,
        type: 'film',
      );
    }
  }

  Widget _buildPersonsSection(BuildContext context,List<PersonResponse> persons) {
    if(persons.isEmpty) {
      return _buildDefaultSection(context,'Personnages');
    } else {
      final List<Map<String, String>> items = persons.map((person) {
        return {
          'imageUrl': person.image?.smallUrl ?? '',
          'title': person.name ?? 'Unknown Title',
          'url': person.apiDetailUrl ?? '',
        };
      }).toList();
      return HorizontalItemList(
        title: 'Personnages',
        items: items,
        btnVoirPlus: false,
        type: 'personnage',

      );
    }
  }

  Widget _buildDefaultSection(BuildContext context , String title) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        color: AppColors.cardBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: textTheme.headlineLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
            child: Center(
              child: Text(
                'Aucun résultat trouvé',
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}