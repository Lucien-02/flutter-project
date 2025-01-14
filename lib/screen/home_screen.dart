import 'package:comics_app/bloc/comic_bloc.dart';
import 'package:comics_app/bloc/serie_bloc.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_tab.dart';
import 'comics_tab.dart';
import 'series_tab.dart';
import 'films_tab.dart';
import 'search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    ComicsTab(),
    SeriesTab(),
    FilmsTab(),
    SearchTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundScreen,
      appBar: _currentIndex == 0
          ? PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 160,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 34.0),
            // Adds top and left padding
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
      body: _currentIndex == 0
          ? MultiBlocProvider(
        providers: [
          BlocProvider<SerieBloc>(
            create: (_) => SerieBloc(apiManager),
          ),
          BlocProvider<ComicBloc>(
            create: (_) => ComicBloc(apiManager),
          ),
                    /*BlocProvider<FilmBloc>(
                      create: (_) => FilmBloc(filmApiManager: FilmApiManager()),
                    ),*/
        ],
        child: _tabs[_currentIndex],
      )
          :
      _currentIndex == 1
          ? BlocProvider<ComicBloc>(
        create: (_) => ComicBloc(apiManager),
        child: _tabs[_currentIndex],
      ) :
      _currentIndex == 2
          ? BlocProvider<SerieBloc>(
        create: (_) => SerieBloc(apiManager),
        child: _tabs[_currentIndex],
      ) :
      _currentIndex == 3
          ? BlocProvider<SerieBloc>(
        create: (_) => SerieBloc(apiManager),
        child: _tabs[_currentIndex],
      )
          : _tabs[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: SizedBox(
          height: 80,
          child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
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
                    label: "Accueil"),
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
                    ), label: "Comics"),
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
                    ), label: "Séries"),
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
                    ), label: "Films"),
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
                    ), label: "Recherche"),
              ]
          ),

        ),
      ),
    );
  }
}


