import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';

abstract interface class TrackingRepository {
  Stream<Result<RemoteDataEntity>> getOrderFromRemote(String orderId);
}
