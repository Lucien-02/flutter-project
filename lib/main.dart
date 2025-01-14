import 'package:comics_app/screen/demo_request_screen.dart';
import 'package:comics_app/screen/detail_comic_screen.dart';
import 'package:comics_app/screen/detail_serie_screen.dart';
import 'package:comics_app/screen/home_screen.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
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
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 17.0,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    labelLarge : TextStyle(
        color: Colors.white,
        fontSize: 22.0,
        fontWeight: FontWeight.w900
    ),
    labelMedium: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic
    ),
    labelSmall : TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w400
    ),
    bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w400
    ),
  );

  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
      routes: [
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
      ],
    ),
  ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: Locale('fr', 'FR'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
    );
  }
}
