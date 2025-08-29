

import 'package:flower_e_commerce/features/profile/data/source/profile_remote_data_source.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRepositoryImp(this._profileRemoteDataSource);

}