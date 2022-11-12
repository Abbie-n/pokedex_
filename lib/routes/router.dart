import 'package:auto_route/auto_route.dart';
import 'package:pokedex/features/favourites/presentation/favourites_tab.dart';
import 'package:pokedex/features/home/presentation/home_screen.dart';
import 'package:pokedex/features/pokemons/multi_view/presentation/multi_view_tab.dart';
import 'package:pokedex/features/pokemons/single_view/presentation/single_view_screen.dart';

@CupertinoAutoRouter(
  preferRelativeImports: true,
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: HomeScreen),
    AutoRoute(page: MultiViewTab),
    AutoRoute(page: FavouritesTab),
    AutoRoute(page: SingleViewScreen),
  ],
)
class $AppRouter {}
