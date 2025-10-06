import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/repository/tracking_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class GetDataFromRemoteUseCase {
  final TrackingRepository _trackingRepository;

  GetDataFromRemoteUseCase(this._trackingRepository);

   Stream<Result<RemoteDataEntity>> getOrderFromRemote(String orderId){
    return _trackingRepository.getOrderFromRemote(orderId);
  }
}
