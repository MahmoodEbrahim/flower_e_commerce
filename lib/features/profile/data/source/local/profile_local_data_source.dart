import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';

abstract class ProfileLocalDataSource {
  Future<LocalDsResult<List<GenericJsonSectionEntity>>> getJsonSections(String jsonPath,String jsonKey) ;
}