import 'package:bharatnxt/features/listing/data/models/suggestions_result_model.dart';

abstract class SuggestionRepository {
  Future<SuggestionsResultModel> getSuggestions({
    required int page,
    required int limit,
  });
}
