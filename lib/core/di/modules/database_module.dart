import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';



@module
abstract class DatabaseModule {
  @preResolve
  Future<SharedPreferences> get providesharedPreferences async {
    return await SharedPreferences.getInstance();
  }

 


 
}