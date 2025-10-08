import 'package:firebase_core/firebase_core.dart';
import 'package:flower_e_commerce/firebase_options.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';



@module
abstract class DatabaseModule {
  @preResolve
  Future<SharedPreferences> get providesharedPreferences async {
    return await SharedPreferences.getInstance();
  }


  @preResolve
  Future<FirebaseApp> get firebaseApp => Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
  );

 


 
}