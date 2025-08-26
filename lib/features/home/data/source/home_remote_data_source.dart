
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';

import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeEntity> getHomeData();
}