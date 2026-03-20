import 'package:bharatnxt/features/listing/domain/entities/pagination_meta.dart';
import 'package:bharatnxt/features/listing/domain/entities/suggestion.dart';

abstract class SuggestionsResult {
  List<Suggestion> get suggestions;
  PaginationMeta get pagination;
}
