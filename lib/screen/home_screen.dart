import 'package:comics_app/bloc/comic_bloc.dart';
import 'package:comics_app/bloc/film_bloc.dart';
import 'package:comics_app/bloc/serie_bloc.dart';
import 'package:comics_app/bloc/tab_bloc.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import 'home_tab.dart';
import 'comics_tab.dart';
import 'series_tab.dart';
import 'films_tab.dart';
import 'search_tab.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> _tabs = [
    HomeTab(),
    BlocProvider(
      create: (_) => ComicBloc(ApiManager())..add(
        LoadComicListEvent(
          fieldList: 'id,image,name,issue_number,api_detail_url,date_added',
        ),
      ),
      child: ComicsTab(),
    ),
    BlocProvider(
      create: (context) => SerieBloc(ApiManager())..add(
        LoadSerieListEvent(
          fieldList: 'id,image,name,publisher,count_of_episodes,start_year,api_detail_url',
        ),
      ),
      child: SeriesTab(),
    ),
    //SeriesTab(),
    BlocProvider(
      create: (_) => FilmBloc(ApiManager())..add(
        LoadFilmListEvent(
          fieldList: 'id,image,name,runtime,api_detail_url,date_added',
        ),
      ),
      child: FilmsTab(),
    ),
    SearchTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => TabBloc(),
      child: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundScreen,
            appBar: state.currentIndex == 0
                ? PreferredSize(
              preferredSize: Size.fromHeight(160),
              child: AppBar(
                backgroundColor: Colors.transparent,
                toolbarHeight: 160,
                elevation: 0,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(left: 32.0, top: 34.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bienvenue !',
                      style: textTheme.displayLarge,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 9.5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          SizedBox(
                            width: 122,
                            height: 160,
                            child: SvgPicture.asset(
                              'assets/icons/astronaut.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
            )
                : null,
            body: IndexedStack(
              index: state.currentIndex,
              children: _tabs,
            ),
            bottomNavigationBar: BlocBuilder<TabBloc, TabState>(
              builder: (context, state) {
                return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: SizedBox(
                      height: 80,
                      child: BottomNavigationBar(
                        currentIndex: state.currentIndex,
                        onTap: (index) {
                          BlocProvider.of<TabBloc>(context).add(SelectTabEvent(index));
                        },
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: AppColors.bottomBarBackground,
                        selectedItemColor: AppColors.bottomBarTextSelected,
                        unselectedItemColor: AppColors.bottomBarTextUnselected,
                        showUnselectedLabels: true,
                        items: [
                          BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                          'assets/icons/navbar_home.svg',
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                          AppColors.bottomBarTextUnselected, BlendMode.srcIn),
                          ),
                          activeIcon: SvgPicture.asset(
                          'assets/icons/navbar_home.svg',
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                          AppColors.bottomBarTextSelected, BlendMode.srcIn),
                          ),
                          label: "Accueil",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                            'assets/icons/navbar_comics.svg',
                            height: 24,
                            width: 24,
                            colorFilter: const ColorFilter.mode(
                              AppColors.bottomBarTextUnselected, BlendMode.srcIn),
                            ),
                            activeIcon: SvgPicture.asset(
                              'assets/icons/navbar_comics.svg',
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                              AppColors.bottomBarTextSelected, BlendMode.srcIn),
                            ),
                            label: "Comics",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              'assets/icons/navbar_series.svg',
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                              AppColors.bottomBarTextUnselected, BlendMode.srcIn),
                            ),
                            activeIcon: SvgPicture.asset(
                              'assets/icons/navbar_series.svg',
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                              AppColors.bottomBarTextSelected, BlendMode.srcIn),
                            ),
                            label: "Séries",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              'assets/icons/navbar_movies.svg',
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                              AppColors.bottomBarTextUnselected, BlendMode.srcIn),
                            ),
                            activeIcon: SvgPicture.asset(
                              'assets/icons/navbar_movies.svg',
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                              AppColors.bottomBarTextSelected, BlendMode.srcIn),
                            ),
                            label: "Films",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              'assets/icons/navbar_search.svg',
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                              AppColors.bottomBarTextUnselected, BlendMode.srcIn),
                            ),
                            activeIcon: SvgPicture.asset(
                              'assets/icons/navbar_search.svg',
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                              AppColors.bottomBarTextSelected, BlendMode.srcIn),
                            ),
                            label: "Recherche",
                          ),
                         ],
                      ),
                    ),
                );
            },
          ),
          );
        },
      ),
    );
  }
}
