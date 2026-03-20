import 'package:bharatnxt/features/listing/data/datasources/suggestion_datasource.dart';
import 'package:bharatnxt/features/listing/data/models/suggestions_result_model.dart';
import 'package:bharatnxt/features/listing/domain/repositories/suggestion_repository.dart';

class SuggestionRepositoryImpl implements SuggestionRepository {
  final SuggestionDataSource _dataSource;

  const SuggestionRepositoryImpl(this._dataSource);

  @override
  Future<SuggestionsResultModel> getSuggestions({
    required int page,
    required int limit,
  }) =>
      _dataSource.getSuggestions(page: page, limit: limit);
}
