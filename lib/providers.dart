import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex/core/config/injection.dart';
import 'package:pokedex/core/services/api/api_service.dart';
import 'package:pokedex/core/services/storage/offline_client.dart';
import 'package:pokedex/features/repository/data_repository.dart';
import 'package:pokedex/features/repository/data_repository_impl.dart';

final dataRepositoryProvider = Provider<DataRepository>(
  (ref) => DataRepositoryImpl(
    offlineClient: getIt<OfflineClient>(),
    apiService: getIt<ApiService>(),
  ),
);
