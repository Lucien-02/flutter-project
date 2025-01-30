import 'package:flutter/material.dart';
import 'package:comics_app/manager/api_manager.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter_svg/svg.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _performSearch(String query) async {
    try {
      // Créez une instance de ApiManager
      final apiManager = ApiManager();

      // Paramètres pour la recherche
      String searchQuery = query; // Le mot-clé de recherche
      String resources =
          'movie,issue,series,character'; // Limiter aux ressources spécifiques

      // Appel à l'API de recherche
      var searchResponse = await apiManager.loadSearchFromAPI(
        query: searchQuery,
        resources: resources,
        fieldList: 'name,',
        limit: 10,
        offset: 0,
      );

      // Affichage des résultats
      print(
          'Nombre total de résultats : ${searchResponse.numberOfTotalResults}');
      for (var result in searchResponse.results) {
        print(
            'Nom : ${result.name}, Type de ressource : ${result.resourceType}');
      }
    } catch (e) {
      print('Erreur lors de la recherche : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiManager = ApiManager();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 163,
            decoration: const BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 17),
                Text('Recherche', style: textTheme.displayLarge),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Comic,film,série...',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: AppColors.bottomBarBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.bottomBarTextUnselected,
                      ),
                      onPressed: () {
                        String query =
                            _controller.text; // Récupérer le texte saisi
                        _performSearch(
                            query); // Appeler _performSearch avec la valeur de la recherche
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    _performSearch(value);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Carte contenant le texte
                  Card(
                    color: AppColors.cardBackground,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: SizedBox(
                      width: 348,
                      height: 131,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16.0, right: 120.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Utilisation d'un widget Text pour justifier le texte
                            Text(
                              'Saisissez une recherche pour trouver un comics, film, série ou personnage.',
                              textAlign:
                                  TextAlign.justify, // Justification du texte
                              style: textTheme.headlineSmall?.copyWith(
                                color: AppColors.bottomBarTextSelected,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Image SVG qui dépasse en haut à gauche
                  Positioned(
                    top: -20,
                    right: -10,
                    child: SizedBox(
                      height: 90,
                      child: SvgPicture.asset(
                        'assets/icons/astronaut.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
