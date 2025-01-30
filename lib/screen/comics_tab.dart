import 'package:comics_app/bloc/comic_bloc.dart';
import 'package:comics_app/component/card_widget.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:comics_app/theme/app_colors.dart';

class ComicsTab extends StatefulWidget {
  @override
  _ComicsTabState createState() => _ComicsTabState();
}

class _ComicsTabState extends State<ComicsTab> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ComicBloc>(context).add(LoadComicListEvent(
        fieldList: 'id,image,name,issue_number,api_detail_url,date_added'));
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_scrollController.position.outOfRange) {
      final currentState = BlocProvider.of<ComicBloc>(context).state;
      print(currentState);
      if (currentState is ComicLoadedState) {
        BlocProvider.of<ComicBloc>(context).add(LoadMoreComicsEvent(
            fieldList: 'id,image,name,issue_number,api_detail_url,date_added'));
      }
    }
  }

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
    final apiManager = ApiManager();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundScreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Comics les plus populaires',
          style: textTheme.displayLarge,
        ),
      ),
      body: BlocBuilder<ComicBloc, ComicState>(
        builder: (context, ComicState state) {
          if (state is ComicLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ComicLoadedState) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.comics.length + 1,
              itemBuilder: (context, index) {
                if (index < state.comics.length) {
                  final comic = state.comics[index];
                  final formattedDate = formatDate(comic.dateAdded ?? "");
                  final List<Map<IconData, String>> iconTextPairs = [
                    {
                      Icons.book: "N° ${comic.issueNumber ?? ' '}",
                    },
                    {
                      Icons.calendar_today: formattedDate,
                    },
                  ];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CardWidget(
                      id: comic.id ?? 0,
                      url: comic.apiDetailUrl ?? "",
                      name: comic.name ?? "",
                      subtitle: "",
                      keyValuePairs: iconTextPairs,
                      imageUrl: comic.image?.smallUrl ?? "",
                      rank: comic.id ?? 0,
                      type: 'comic',
                    ),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          } else if (state is ComicErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Erreur : ${state.message}',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ComicBloc>().add(
                            LoadComicListEvent(
                              fieldList:
                                  'id,image,name,issue_number,api_detail_url',
                              limit: 50,
                            ),
                          );
                    },
                    child: Text('Réessayer'),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              'Veuillez charger la liste des séries.',
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
