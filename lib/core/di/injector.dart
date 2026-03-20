import 'package:get_it/get_it.dart';
import 'package:bharatnxt/core/local/hive_service.dart';
import 'package:bharatnxt/core/local/local_storage_service.dart';
import 'package:bharatnxt/features/listing/data/datasources/suggestion_mock_datasource.dart';
import 'package:bharatnxt/features/listing/data/repositories/suggestion_repository_impl.dart';
import 'package:bharatnxt/features/listing/domain/repositories/suggestion_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final hiveService = HiveService();
  await hiveService.init();
  sl.registerSingleton<LocalStorageService>(hiveService);

  sl.registerLazySingleton<SuggestionRepository>(
    () => SuggestionRepositoryImpl(SuggestionMockDataSource()),
  );
}
