import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/data/source/tracking_remote_data_source.dart';
import 'package:flower_e_commerce/features/tracking_order/remote/firebase/client/tracking_firebase_service.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: TrackingRemoteDataSource)

class TrackingFirebaseDataSourceImp implements TrackingRemoteDataSource {
 final  TrackingFirebaseService _trackingApiService;

  TrackingFirebaseDataSourceImp(this._trackingApiService);

  @override
  Stream<Result<RemoteDataEntity>> getOrderFromRemote(String orderId) async* {
    try {
      final res = _trackingApiService.getDataFromRemote(orderId);
      await for (final data in res) {
        final orderEntity = data.toEntity();

        yield SucessResult(orderEntity);
      }
    } catch (error) {
      yield FailedResult(error.toString());
    }
  }

 
}