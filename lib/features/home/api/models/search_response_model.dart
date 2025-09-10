import 'package:flower_e_commerce/features/home/api/models/meta_data_dto.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'search_response_model.g.dart';
@JsonSerializable()
class SearchResponseModel {
    @JsonKey(name: "message")
    final String? message;
    @JsonKey(name: "metadata")
    final MetaDataDto? metadata;
    @JsonKey(name: "products")
    final List<ProductModel>? products;

    SearchResponseModel({
        this.message,
        this.metadata,
        this.products,
    });

    factory SearchResponseModel.fromJson(Map<String, dynamic> json) => _$SearchResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$SearchResponseModelToJson(this);
}





    

