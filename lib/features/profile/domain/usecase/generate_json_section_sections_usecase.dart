import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenerateJsonSectionsUseCase {
  ProfileRepository _profileRepository;
  GenerateJsonSectionsUseCase(this._profileRepository);

  Future<ApiResult<List<GenericJsonSectionEntity>>> call(String jsonPath,String jsonKey){
    return  _profileRepository.getJsonSections(jsonPath,jsonKey);
  }
}