
import '../models/homemodel.dart';

abstract class HomeRemoteDataSource {
  Future<Homemodel> getHomeData();
}