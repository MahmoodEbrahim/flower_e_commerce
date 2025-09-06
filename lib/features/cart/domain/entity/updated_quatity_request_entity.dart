import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_request_body.dart';

class UpdatedQuatityRequestEntity extends Equatable {
  final String itemId;
  final UpdatedRequestBodyEntity updatedRequestBody;

  const UpdatedQuatityRequestEntity({
    required this.itemId,
    required this.updatedRequestBody,
  });

  UpdatedQuatityRequestEntity copyWith({
    String? itemId,
    UpdatedRequestBodyEntity? updatedRequestBody,
  }) {
    return UpdatedQuatityRequestEntity(
      itemId: itemId ?? this.itemId,
      updatedRequestBody: updatedRequestBody ?? this.updatedRequestBody,
    );
  }

  @override
  List<Object> get props => [itemId, updatedRequestBody];
}
