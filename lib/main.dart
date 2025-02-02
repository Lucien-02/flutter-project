import 'package:comics_app/bloc/comic_bloc.dart';
import 'package:comics_app/bloc/film_bloc.dart';
import 'package:comics_app/bloc/serie_bloc.dart';
import 'package:comics_app/bloc/tab_bloc.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/screen/comics_tab.dart';
import 'package:comics_app/screen/demo_request_screen.dart';
import 'package:comics_app/screen/detail_comic_screen.dart';
import 'package:comics_app/screen/detail_film_screen.dart';
import 'package:comics_app/screen/films_tab.dart';
import 'package:comics_app/screen/series_tab.dart';
import 'package:comics_app/screen/detail_personnage_screen.dart';
import 'package:comics_app/screen/detail_serie_screen.dart';
import 'package:comics_app/screen/home_screen.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() {
  initializeDateFormatting('fr_FR', null).then((_) => runApp( MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TextTheme customTextTheme = GoogleFonts.nunitoTextTheme().copyWith(
    displayLarge: const TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
    ),
    headlineMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 17.0,
    ),
    headlineSmall: const TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    labelLarge : const TextStyle(
        color: Colors.white,
        fontSize: 22.0,
        fontWeight: FontWeight.w900
    ),
    labelMedium: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic
    ),
    labelSmall : const TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w400
    ),
    bodyMedium: const TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w400
    )
  );

  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>  HomeScreen(),
      routes: [
        GoRoute(
            path: '/series',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (_) => SerieBloc(ApiManager())..add(
                LoadSerieListEvent(
                  fieldList: 'id,image,name,publisher,count_of_episodes,start_year,api_detail_url',
                ),
              ),
              child: SeriesTab(),
            );
          },

        ),

        GoRoute(
          path: '/comics',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (_) => ComicBloc(ApiManager())..add(
                LoadComicListEvent(
                  fieldList: 'id,image,name,issue_number,api_detail_url,date_added',
                ),
              ),
              child: ComicsTab(),
            );
          },

        ),

        GoRoute(
          path: '/films',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (_) => FilmBloc(ApiManager())..add(
                LoadFilmListEvent(
                  fieldList: 'id,image,name,runtime,api_detail_url,date_added',
                ),
              ),
              child: FilmsTab(),
            );
          },

        ),

        GoRoute(
            path: '/serie-detail',
            builder: (BuildContext context, GoRouterState state) {
              final data = state.extra! as Map<String,dynamic>;
              return DetailSerieScreen(id: data["id"], title: data["title"], url: data["url"], imageUrl: data["imageUrl"]);
            }

        ),
        GoRoute(
            path: '/comic-detail',
            builder: (BuildContext context, GoRouterState state) {
              final data = state.extra! as Map<String,dynamic>;
              return DetailComicScreen(id: data["id"], title: data["title"], url: data["url"], imageUrl: data["imageUrl"]);
            }

        ),
        GoRoute(
            path: '/film-detail',
            builder: (BuildContext context, GoRouterState state) {
              final data = state.extra! as Map<String,dynamic>;
              return DetailFilmScreen(id: data["id"], title: data["title"], url: data["url"], imageUrl: data["imageUrl"]);
            }

        ),
        GoRoute(
            path: '/personnage-detail',
            builder: (BuildContext context, GoRouterState state) {
              final data = state.extra! as Map<String,dynamic>;
              return DetailPersonnageScreen(title: data["title"], url: data["url"], imageUrl: data["imageUrl"]);
            }

        ),
      ],
    ),
  ]);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBloc>(
      create: (_) => TabBloc(),
      child: MaterialApp.router(
        locale: Locale('fr', 'FR'),
        debugShowCheckedModeBanner: false,
        title: 'Comics App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: customTextTheme,
          scaffoldBackgroundColor: Colors.transparent,
        ),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('fr'),
        ],
        routerConfig: _router,
      ),
    );
  }
}
