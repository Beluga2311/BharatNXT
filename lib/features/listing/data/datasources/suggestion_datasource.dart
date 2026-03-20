import 'package:bharatnxt/features/listing/data/models/suggestions_result_model.dart';

abstract class SuggestionDataSource {
  Future<SuggestionsResultModel> getSuggestions({
    required int page,
    required int limit,
  });
}
