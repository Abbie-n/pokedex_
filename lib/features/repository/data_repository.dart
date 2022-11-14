import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:pokedex/core/services/api/api_service.dart';
import 'package:pokedex/core/services/storage/offline_client.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/model/pokemon_model.dart';
import 'package:pokedex/features/repository/data_repository_impl.dart';

const favouritesKey = 'FAVOURITES-KEY';

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
    jsonDecode(dataString).forEach((x) => pokemons.add(x));

    return pokemons;
  }

  @override
  Future<List<PokemonDetails>> getPokemons() async {
    List<PokemonDetails> pokemons = [];

    try {
      // gets list of pokemons
      final response = await apiService.get('/');

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

      return pokemons;
    } catch (e) {
      logDebug(e);
      return pokemons;
    }
  }

  @override
  Future<bool> removeFavourite(PokemonDetails pokemon) async {
    List<PokemonDetails> pokemons = [];

    // gets persisted favourites
    final dataString = await offlineClient.getString(favouritesKey);

    if (dataString == null) {
      return false;
    }

    jsonDecode(dataString).forEach((x) => pokemons.add(x));

    pokemons.removeWhere((e) => e.id == pokemon.id);

    // saves modified list
    final res =
        await offlineClient.setString(favouritesKey, jsonEncode(pokemons));
    return res;
  }

  @override
  Future<bool> saveFavourites(PokemonDetails pokemon) async {
    List<PokemonDetails> pokemons = [];

    // gets persisted favourites
    final dataString = await offlineClient.getString(favouritesKey);

    if (dataString == null) {
      final res =
          await offlineClient.setString(favouritesKey, jsonEncode(pokemon));
      return res;
    }

    // updates list with new favourite
    jsonDecode(dataString).forEach((x) => pokemons.add(x));
    pokemons.add(pokemon);

    // saves modified list
    final res =
        await offlineClient.setString(favouritesKey, jsonEncode(pokemons));
    return res;
  }
}
