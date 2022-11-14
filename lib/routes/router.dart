import 'package:auto_route/auto_route.dart';
import 'package:pokedex/features/presentation/home/favourites_tab.dart';
import 'package:pokedex/features/presentation/home/home_screen.dart';
import 'package:pokedex/features/presentation/pokemon_details/pokemon_details_screen.dart';

@CupertinoAutoRouter(
  preferRelativeImports: true,
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: HomeScreen),
    AutoRoute(page: FavouritesTab),
    AutoRoute(page: PokemonDetailsScreen),
  ],
)
class $AppRouter {}
