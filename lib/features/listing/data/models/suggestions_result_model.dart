import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bharatnxt/features/listing/data/models/pagination_meta_model.dart';
import 'package:bharatnxt/features/listing/data/models/suggestion_model.dart';
import 'package:bharatnxt/features/listing/domain/entities/suggestions_result.dart';

part 'suggestions_result_model.freezed.dart';
part 'suggestions_result_model.g.dart';

@freezed
abstract class SuggestionsResultModel with _$SuggestionsResultModel
    implements SuggestionsResult {
  const factory SuggestionsResultModel({
    required List<SuggestionModel> suggestions,
    required PaginationMetaModel pagination,
  }) = _SuggestionsResultModel;

  factory SuggestionsResultModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestionsResultModelFromJson(json);
}
