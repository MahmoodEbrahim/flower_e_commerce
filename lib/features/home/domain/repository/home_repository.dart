
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getHomeData();
}