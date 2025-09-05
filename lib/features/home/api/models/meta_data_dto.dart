import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'meta_data_dto.g.dart';

@JsonSerializable()
class MetaDataDto extends Equatable {
  @JsonKey(name: JsonSerlizableConstants.currentPage)
  final int? currentPage;
  @JsonKey(name: JsonSerlizableConstants.totalPages)
  final int? totalPages;
  @JsonKey(name: JsonSerlizableConstants.limit)
  final int? limit;
  @JsonKey(name: JsonSerlizableConstants.totalItems)
  final int? totalItems;

  @JsonKey(name: 'some_field')
  final String? someField;

  const MetaDataDto({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
    this.someField,
  });

  factory MetaDataDto.fromJson(Map<String, dynamic> json) =>
      _$MetaDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataDtoToJson(this);

  @override
  List<Object?> get props =>
      [currentPage, totalPages, limit, totalItems, someField];
}
