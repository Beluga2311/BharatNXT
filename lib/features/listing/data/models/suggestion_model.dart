import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bharatnxt/features/listing/domain/entities/suggestion.dart';

part 'suggestion_model.freezed.dart';
part 'suggestion_model.g.dart';

@freezed
abstract class SuggestionModel with _$SuggestionModel implements Suggestion {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SuggestionModel({
    required int id,
    required String title,
    required String description,
  }) = _SuggestionModel;

  factory SuggestionModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestionModelFromJson(json);
}
