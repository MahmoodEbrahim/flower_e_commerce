import 'package:flower_e_commerce/features/profile/api/client/profile_api_service.dart';
import 'package:flower_e_commerce/features/profile/data/source/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  final ProfileApiService _profileApiService;
  ProfileRemoteDataSourceImp(this._profileApiService);
 
}
