import 'package:comics_app/bloc/person_bloc.dart';
//import 'package:comics_app/localization.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';

class PersonWidget extends StatelessWidget {
  final String person_url;
  final String role;

  const PersonWidget({
    super.key,
    required this.person_url,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager();
    final localizations = S.of(context);

    //String translatedRole = localizations?.translateRoles(role) ?? role;
    String translatedRole = role.split(',').map((role) {
      switch (role.trim().toLowerCase()) {
        case 'writer':
          return localizations.writer;
        case 'penciler':
          return localizations.penciler;
        case 'inker':
          return localizations.inker;
        case 'editor':
          return localizations.editor;
        case 'letterer':
          return localizations.letterer;
        case 'cover':
          return localizations.cover;
        case 'artist':
          return localizations.artist;
        default:
          return role; // Return the original role if not found
      }
    }).join(', ');

    return BlocProvider(
      create: (context) => PersonBloc(apiManager)
        ..add(
          LoadPersonEvent(
            baseUrl: person_url,
            fieldList: 'id,image,name,api_detail_url',
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
                BlocBuilder<PersonBloc, PersonState>(
                  builder: (context, PersonState state) {
                    if (state is PersonLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is OnePersonLoadedState) {
                      final person = state.person;

                      if (person != null) {
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
                                        person.image?.iconUrl?.isNotEmpty ?? false
                                            ? person.image?.iconUrl ??
                                            "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg"
                                            : "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg",
                                      ),
                                    ),
                                    const SizedBox(width: 15),


                                    ConstrainedBox(
                                        constraints: const BoxConstraints(maxWidth: 200),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              person.name ?? ' ',
                                              style: const TextStyle(fontSize: 16, color: Colors.white),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              translatedRole ?? '',
                                              style: const TextStyle(fontSize: 14, color: Colors.white70, fontStyle: FontStyle.italic),
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
                        return const Center(
                          child: Text(
                            'Erreur : Auteur non existant',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        );
                      }
                    } else if (state is PersonErrorState) {
                      return Center(
                        child: Text(
                          'Erreur : ${state.message}',
                          style: const TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Veuillez charger l auteur.',
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