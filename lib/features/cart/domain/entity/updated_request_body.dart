import 'package:equatable/equatable.dart';

class UpdatedRequestBodyEntity extends Equatable {
  final int quantity;

  const UpdatedRequestBodyEntity({
    required this.quantity,
  });

  UpdatedRequestBodyEntity copyWith({
    int? quantity,
  }) {
    return UpdatedRequestBodyEntity(
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [quantity];
}
