import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/tracking_order/data/source/tracking_remote_data_source.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/repository/tracking_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackingRepository)
class TrackingRepositoryImp implements TrackingRepository {
  final TrackingRemoteDataSource _trackingRemoteDataSource;
  const TrackingRepositoryImp(this._trackingRemoteDataSource);

  @override
  Stream<Result<RemoteDataEntity>> getOrderFromRemote(String orderId)  {
    return  _trackingRemoteDataSource.getOrderFromRemote(orderId);
  }
}
