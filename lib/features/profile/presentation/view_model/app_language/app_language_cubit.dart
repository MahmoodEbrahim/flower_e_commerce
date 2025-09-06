import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/app_language/app_language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());
  String currentLanguage = "en";
  void changeLanguage(String langCode)async {
    currentLanguage = langCode;
    await  UserLocalStorage.saveLanguage(langCode);
    emit(SaveLanguageState());




  }
  void getLanguage() async{
    String? lang = await UserLocalStorage.getLanguage();
    if (lang != null) {
      if (lang=="en"){
        currentLanguage = "en";

      }
      else
      {
        currentLanguage = "ar";
      }


    }
    emit(getLanguageState());
  }
}