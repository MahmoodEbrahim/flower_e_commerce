import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenerateJsonSectionsUseCase {
  ProfileRepository _profileRepository;
  GenerateJsonSectionsUseCase(this._profileRepository);

  Future<LocalDsResult<List<GenericJsonSectionEntity>>> call(String jsonPath,String jsonKey){
    return  _profileRepository.getJsonSections(jsonPath,jsonKey);
  }
}