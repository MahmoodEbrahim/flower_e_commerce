import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'meta_data_dto.g.dart';

@JsonSerializable()
class MetaDataDto extends Equatable {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  const MetaDataDto({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory MetaDataDto.fromJson(Map<String, dynamic> json) =>
      _$MetaDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataDtoToJson(this);

  @override
  List<Object?> get props => [currentPage, totalPages, limit, totalItems];
}
