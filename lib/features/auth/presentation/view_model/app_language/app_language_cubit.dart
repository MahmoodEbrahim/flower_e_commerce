import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/sign_out_response/sign_out_response.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/get_log_out_use_case.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/get_profile_data.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/app_language/app_language_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this._getProfileDataUseCase, this._getLogOutUseCase)
    : super(SettingInitial());
  final GetProfileDataUseCase _getProfileDataUseCase;
  final GetLogOutUseCase _getLogOutUseCase;
  String currentLanguage = "en";
  void changeLanguage(String langCode) async {
    currentLanguage = langCode;
    await UserLocalStorage.saveLanguage(langCode);
    emit(SaveLanguageState());
  }

  void getLanguage() async {
    String? lang = await UserLocalStorage.getLanguage();
    if (lang != null) {
      if (lang == "en") {
        currentLanguage = "en";
      } else {
        currentLanguage = "ar";
      }
    }
    emit(getLanguageState());
  }

  UserModel? userModel;
  Future<void> getProfileData(String token) async {
    final result = await _getProfileDataUseCase.getProfileData(token);
    switch (result) {
      case SucessResult<UserModel>():
        userModel = result.sucessResult;
        emit(GetProfileDataSuccessState(result.sucessResult));
      case FailedResult<UserModel>():
        emit(GetProfileDataErrorState(result.errorMessage));
    }
  }

  Future<void> logOut(String token) async {
    final result = await _getLogOutUseCase.logOut(token);
    switch (result) {
      case SucessResult<SignOutResponse>():
        emit(GetLogOutSuccessState());
      case FailedResult<SignOutResponse>():
        emit(GetLogOutErrorState(result.errorMessage));
    }
  }
}
