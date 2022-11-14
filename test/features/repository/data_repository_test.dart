import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/features/repository/data_repository.dart';
import 'package:pokedex/features/repository/data_repository_impl.dart';

import '../../mock_api_service.dart';
import '../../mock_data.dart';
import '../../mock_offline_client.dart';

void main() {
  group('DataRepository test', () {
    late MockApiService mockApiService;
    late MockOfflineClient mockOfflineClient;
    late DataRepository repository;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      mockApiService = MockApiService();
      mockOfflineClient = MockOfflineClient();

      repository = DataRepositoryImpl(
        apiService: mockApiService,
        offlineClient: mockOfflineClient,
      );
    });

    group('Pokemons', () {
      test('Should get pokemons', () async {
        // arrange
        when(() => mockApiService.get('/'))
            .thenAnswer((realInvocation) => Future.value(mockPokemonModel));

        when(() => mockApiService.get('/${mockPokemonModel.results![0].name}'))
            .thenAnswer((realInvocation) => Future.value(mockPokemonModel));

        //assert
        expect(repository.getPokemons(), isA<Future<dynamic>>());
      });

      test('Should get cached pokemons', () async {
        // arrange
        when(() => mockOfflineClient.setString(
                cachedPokemonsKey, jsonEncode(mockPokemonDetails)))
            .thenAnswer((realInvocation) => Future.value(true));

        when(() => mockOfflineClient.getString(cachedPokemonsKey)).thenAnswer(
            (realInvocation) => Future.value(jsonEncode(mockPokemonDetails)));

        //assert
        expect(repository.getCachedPokemons(),
            isA<Future<List<PokemonDetails>>>());
      });
    });

    group('Favourites', () {
      test('Should save favourite', () async {
        // arrange
        when(() => mockOfflineClient.getString(favouritesKey))
            .thenAnswer((realInvocation) => Future.value(null));

        when(() => mockOfflineClient.setString(
                favouritesKey, jsonEncode(mockPokemonDetails)))
            .thenAnswer((realInvocation) => Future.value(true));

        //assert
        expect(await repository.saveFavourite(mockPokemonDetails[0]), true);
      });

      test('Should get favourites', () async {
        // arrange
        when(() => mockOfflineClient.setString(
                favouritesKey, jsonEncode(mockPokemonDetails)))
            .thenAnswer((realInvocation) => Future.value(true));

        when(() => mockOfflineClient.getString(favouritesKey)).thenAnswer(
            (realInvocation) => Future.value(jsonEncode(mockPokemonDetails)));

        //assert
        expect(repository.getFavourites(), isA<Future<List<PokemonDetails>>>());
      });

      test('Should remove favourite if it exists', () async {
        // arrange

        when(() => mockOfflineClient.getString(favouritesKey))
            .thenAnswer((realInvocation) => Future.value(null));

        when(() => mockOfflineClient.setString(
                favouritesKey, jsonEncode(mockPokemonDetails)))
            .thenAnswer((realInvocation) => Future.value(true));

        //assert
        expect(await repository.removeFavourite(mockPokemonDetails[0]), false);
      });

      test('Should check if item is already added as favourite', () async {
        // arrange
        when(() => mockOfflineClient.setString(
                favouritesKey, jsonEncode(mockPokemonDetails)))
            .thenAnswer((realInvocation) => Future.value(true));

        when(() => mockOfflineClient.getString(favouritesKey)).thenAnswer(
            (realInvocation) => Future.value(jsonEncode(mockPokemonDetails)));

        //assert
        expect(await repository.isFavourite(mockPokemonDetails[0]), true);
      });
    });
  });
}
