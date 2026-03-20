import 'package:bharatnxt/features/listing/data/models/suggestions_result_model.dart';
import 'package:bharatnxt/features/listing/domain/repositories/suggestion_repository.dart';

class GetSuggestionsUseCase {
  final SuggestionRepository _repository;

  const GetSuggestionsUseCase(this._repository);

  Future<SuggestionsResultModel> call({
    required int page,
    int limit = 10,
  }) =>
      _repository.getSuggestions(page: page, limit: limit);
}
