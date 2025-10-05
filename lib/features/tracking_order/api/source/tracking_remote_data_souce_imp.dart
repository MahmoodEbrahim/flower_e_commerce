import 'package:flower_e_commerce/features/tracking_order/api/client/tracking_api_service.dart';
import 'package:flower_e_commerce/features/tracking_order/data/source/tracking_remote_data_source.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: TrackingRemoteDataSource)

class TrackingRemoteDataSourceImp implements TrackingRemoteDataSource {
  TrackingApiService _trackingApiService;

  TrackingRemoteDataSourceImp(this._trackingApiService);

 
}