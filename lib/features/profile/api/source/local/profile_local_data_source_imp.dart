import 'dart:convert';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/utils/json_helpers/json_loader.dart';
import 'package:flower_e_commerce/features/profile/api/models/generic_json_section_model.dart';
import 'package:flower_e_commerce/features/profile/data/source/local/profile_local_data_source.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImp implements ProfileLocalDataSource {
  @override
  Future<ApiResult<List<GenericJsonSectionEntity>>> getJsonSections(String jsonPath,String jsonKey) async {
    try {
      final Map<String, dynamic> jsonMap = await loadJson(jsonPath);
      final  sections = (jsonMap[jsonKey] as List)
          .map((e) => GenericJsonSectionModel.fromJson(e).toEntity())
          .toList();
      return ApiSucessResult(sections);
    } catch (error) {
      return ApiFailedResult(error.toString());
    }
  }
}
