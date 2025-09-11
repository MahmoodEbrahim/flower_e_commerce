import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';

abstract class ProfileLocalDataSource {
  Future<ApiResult<List<GenericJsonSectionEntity>>> getJsonSections(String jsonPath,String jsonKey) ;
}