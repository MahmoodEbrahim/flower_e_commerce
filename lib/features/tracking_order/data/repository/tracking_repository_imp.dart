import 'package:flower_e_commerce/features/tracking_order/data/source/tracking_remote_data_source.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/repository/tracking_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackingRepository)
class TrackingRepositoryImp implements TrackingRepository {

  TrackingRemoteDataSource _trackingRemoteDataSource;
  TrackingRepositoryImp(this._trackingRemoteDataSource);

  
}