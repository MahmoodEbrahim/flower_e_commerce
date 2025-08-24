import 'package:dartz/dartz.dart';

import '../../data/models/homemodel.dart';


abstract class HomeRepository {
  Future<Either<dynamic, Homemodel>> getHomeData();
}