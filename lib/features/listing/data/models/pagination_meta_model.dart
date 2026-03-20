import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bharatnxt/features/listing/domain/entities/pagination_meta.dart';

part 'pagination_meta_model.freezed.dart';
part 'pagination_meta_model.g.dart';

@freezed
abstract class PaginationMetaModel with _$PaginationMetaModel implements PaginationMeta {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaginationMetaModel({
    required int currentPage,
    required int totalPages,
    required int totalItems,
    required int limit,
    required bool hasNext,
    required bool hasPrevious,
  }) = _PaginationMetaModel;
 
  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaModelFromJson(json);
}
