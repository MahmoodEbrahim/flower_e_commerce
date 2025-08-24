
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';

abstract class HomeRepository {
  Future<Homemodel> getHomeData();
}