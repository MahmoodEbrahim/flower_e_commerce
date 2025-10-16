import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_request_body.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'updated_request_body_model.g.dart';

@JsonSerializable()
class UpdatedRequestBodyModel extends Equatable {
  @JsonKey(name: JsonSerlizableConstants.quantityKey)
  final int? quantity;

  const UpdatedRequestBodyModel({
    this.quantity,
  });

  factory UpdatedRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      _$UpdatedRequestBodyModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedRequestBodyModelToJson(this);

  static UpdatedRequestBodyModel toModel(UpdatedRequestBodyEntity entity) {
    return UpdatedRequestBodyModel(quantity: entity.quantity);
  }

  @override
  List<Object?> get props => [quantity];
}
