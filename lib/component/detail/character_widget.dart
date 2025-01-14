import 'package:comics_app/bloc/character_bloc.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterWidget extends StatelessWidget {
  final String character_url;

  const CharacterWidget({
    super.key,
    required this.character_url,
  });

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager();
    return BlocProvider(
      create: (context) => CharacterBloc(apiManager)
        ..add(
          LoadCharacterEvent(
            baseUrl: character_url,
            fieldList: 'id,image,name,api_detail_url,role',
            // filter: 'id:${character_id}',
          ),
        ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<CharacterBloc, CharacterState>(
                  builder: (context, CharacterState state) {
                    if (state is CharacterLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CharacterLoadedState) {
                      final character = state.character;

                      if (character != null) {
                        return GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Avatar
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        character.image?.iconUrl?.isNotEmpty ?? false
                                            ? character.image?.iconUrl ??
                                            "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg"
                                            : "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg",
                                      ),
                                    ),
                                    SizedBox(width: 10),


                                    ConstrainedBox(
                                        constraints: BoxConstraints(maxWidth: 200),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              character.name ?? ' ',
                                              style: TextStyle(fontSize: 14, color: Colors.white),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            )
                        );
                      } else {
                        return Center(
                          child: Text(
                            'Erreur : Personnage non existant',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        );
                      }
                    } else if (state is CharacterErrorState) {
                      return Center(
                        child: Text(
                          'Erreur : ${state.message}',
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Veuillez charger la série.',
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}