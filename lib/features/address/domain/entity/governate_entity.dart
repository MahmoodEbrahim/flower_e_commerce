import 'package:equatable/equatable.dart';

class GovernorateEntity extends Equatable{
  final String id;
  final String nameAr;
  final String nameEn;
const GovernorateEntity({
    required this.id,
  required this.nameAr,
  required this.nameEn,
});
@override
  // TODO: implement props
  List<Object?> get props => [id,nameEn,nameAr];
}