
import 'package:json_annotation/json_annotation.dart';
part 'meta_data_dto.g.dart';
@JsonSerializable()
class MetaDataDto {
    @JsonKey(name: "currentPage")
    int? currentPage;
    @JsonKey(name: "totalPages")
    int? totalPages;
    @JsonKey(name: "limit")
    int? limit;
    @JsonKey(name: "totalItems")
    int? totalItems;

    MetaDataDto({
        this.currentPage,
        this.totalPages,
        this.limit,
        this.totalItems,
    });

    factory MetaDataDto.fromJson(Map<String, dynamic> json) => _$MetaDataDtoFromJson(json);

    Map<String, dynamic> toJson() => _$MetaDataDtoToJson(this);
}
