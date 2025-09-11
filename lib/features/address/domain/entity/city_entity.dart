import 'package:equatable/equatable.dart';

class StateEntity extends Equatable{
final String cityId;
final String governorateId;
final String cityNameAr;
final String cityNameEn;
StateEntity({
  required this.cityId,
  required this.governorateId,
  required this.cityNameAr,
  required this.cityNameEn,
});
@override
  // TODO: implement props
  List<Object?> get props => [cityId,
  governorateId,
  cityNameEn,
  cityNameAr];
}