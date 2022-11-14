import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:pokedex/core/services/api/api_service.dart';
import 'package:pokedex/core/services/storage/offline_client.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/model/pokemon_model.dart';
import 'package:pokedex/features/repository/data_repository.dart';

const favouritesKey = 'FAVOURITES-KEY';
const cachedPokemonsKey = 'CACHED-POKEMONS-KEY';

@Injectable(as: DataRepository)
class DataRepositoryImpl implements DataRepository {
  final ApiService apiService;
  final OfflineClient offlineClient;

  DataRepositoryImpl({
    required this.apiService,
    required this.offlineClient,
  });

  @override
  Future<List<PokemonDetails>> getFavourites() async {
    List<PokemonDetails> pokemons = [];

    // gets persisted favourites
    final dataString = await offlineClient.getString(favouritesKey);

    if (dataString == null) {
      return pokemons;
    }

    // updates list with favourites
    for (final x in jsonDecode(dataString)) {
      pokemons.add(PokemonDetails.fromJson(x));
    }

    return pokemons;
  }

  @override
  Future getPokemons({int currentLength = 12, bool fetchMore = false}) async {
    List<PokemonDetails> pokemons = [];
    int limit = 12;

    try {
      // gets list of pokemons
      if (fetchMore) {
        limit = currentLength + limit;
      }

      final response = await apiService.get('/', params: {'limit': limit});

      if (response == null || response.runtimeType == int) {
        return pokemons;
      }

      // parses data returned
      final data = PokemonModel.fromJson(response);

      while (pokemons.length < data.results!.length) {
        // Loops through pokemons returned and calls endpoint to get details
        for (final p in data.results!) {
          final details = await apiService.get('/${p.name}');

          if (details == null || details.runtimeType == int) {
            return pokemons;
          }

          final data = PokemonDetails.fromJson(details);

          pokemons.add(data);
        }
      }

      await offlineClient.setString(cachedPokemonsKey, jsonEncode(pokemons));
    } catch (e) {
      logDebug(e);
    }
  }

  @override
  Future<List<PokemonDetails>> getCachedPokemons() async {
    List<PokemonDetails> pokemons = [];

    // gets persisted favourites
    final dataString = await offlineClient.getString(cachedPokemonsKey);

    if (dataString == null) {
      return pokemons;
    }

    // updates list with favourites
    for (final x in jsonDecode(dataString)) {
      pokemons.add(PokemonDetails.fromJson(x));
    }

    return pokemons;
  }

  @override
  Future<bool> removeFavourite(PokemonDetails pokemon) async {
    List<PokemonDetails> pokemons = [];

    // gets persisted favourites
    final dataString = await offlineClient.getString(favouritesKey);

    if (dataString == null) {
      return false;
    }

    jsonDecode(dataString)
        .forEach((x) => pokemons.add(PokemonDetails.fromJson(x)));

    pokemons.removeWhere((e) => e.id == pokemon.id);

    // saves modified list
    final res =
        await offlineClient.setString(favouritesKey, jsonEncode(pokemons));
    return res;
  }

  @override
  Future<bool> saveFavourite(PokemonDetails pokemon) async {
    List<PokemonDetails> pokemons = [];

    // gets persisted favourites
    final dataString = await offlineClient.getString(favouritesKey);

    if (dataString == null) {
      pokemons.add(pokemon);

      final res =
          await offlineClient.setString(favouritesKey, jsonEncode(pokemons));
      return res;
    }

    // updates list with new favourite
    jsonDecode(dataString)
        .forEach((x) => pokemons.add(PokemonDetails.fromJson(x)));

    pokemons.add(pokemon);

    // saves modified list
    final res =
        await offlineClient.setString(favouritesKey, jsonEncode(pokemons));
    return res;
  }

  @override
  Future<bool> isFavourite(PokemonDetails pokemon) async {
    List<PokemonDetails> pokemons = [];

    // gets persisted favourites
    final dataString = await offlineClient.getString(favouritesKey);

    if (dataString == null) {
      return false;
    }

    // updates list with favourites
    for (final x in jsonDecode(dataString)) {
      pokemons.add(PokemonDetails.fromJson(x));
    }

    if (pokemons.any((e) => e.id == pokemon.id)) {
      return true;
    }
    return false;
  }
}
