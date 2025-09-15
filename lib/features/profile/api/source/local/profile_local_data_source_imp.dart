import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/core/utils/json_helpers/json_loader.dart';
import 'package:flower_e_commerce/features/profile/api/models/generic_json_section_model.dart';
import 'package:flower_e_commerce/features/profile/data/source/local/profile_local_data_source.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImp implements ProfileLocalDataSource {
  final JsonLoader _jsonLoader;

  ProfileLocalDataSourceImp(this._jsonLoader);

  @override
  Future<LocalDsResult<List<GenericJsonSectionEntity>>> getJsonSections(
      String jsonPath, String jsonKey) async {
    try {
      final Map<String, dynamic> jsonMap = await _jsonLoader.loadJson(jsonPath);
      final sections = (jsonMap[jsonKey] as List)
          .map((e) => GenericJsonSectionModel.fromJson(e).toEntity())
          .toList();
      return LocalDsSucessResult(sections);
    } catch (error) {
      return LocalDsFailedResult(error.toString());
    }
  }
}

