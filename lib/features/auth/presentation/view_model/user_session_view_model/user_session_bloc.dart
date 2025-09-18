import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage_imp.dart';
import 'package:flower_e_commerce/features/auth/data/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'user_session_event.dart';
import 'user_session_state.dart';

@injectable
class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  AuthRepository authRepository;
  final UserLocalStorage userLocalStorage;

  UserSessionBloc(this.authRepository,this.userLocalStorage) : super(const UserSessionState()) {
    on<UserLoggedIn>((event, emit) async {
      print("🔵 [UserSessionBloc] UserLoggedIn event triggered");

      emit(state.copyWith(status: UserSessionStatus.loading));
      print("⏳ [UserSessionBloc] Status -> loading");

      await userLocalStorage.saveToken(event.token);
      print("💾 [UserSessionBloc] Token saved to local storage: ${event.token}");

      emit(state.copyWith(
        status: UserSessionStatus.authenticated,
        token: event.token,
        user: event.user,
      ));
      print("✅ [UserSessionBloc] Status -> authenticated, User: ${event.user.firstName}");
    });

    on<UserLoggedOut>((event, emit) async {
      print("🔵 [UserSessionBloc] UserLoggedOut event triggered");

      emit(state.copyWith(status: UserSessionStatus.loading));
      print("⏳ [UserSessionBloc] Status -> loading");

      await userLocalStorage.clearToken();
      print("🗑 [UserSessionBloc] Token cleared from local storage");

      emit(state.copyWith(
        status: UserSessionStatus.unauthenticated,
        token: null,
        user: null,
      ));
      print("🚪 [UserSessionBloc] Status -> unauthenticated");
    });

    on<LoadUserFromCache>((event, emit) async {
      print("🔵 [UserSessionBloc] LoadUserFromCache event triggered");

      emit(state.copyWith(status: UserSessionStatus.loading));
      print("⏳ [UserSessionBloc] Status -> loading");

      final token = await userLocalStorage.getToken();
      print("📦 [UserSessionBloc] Retrieved token: $token");

      if (token != null && token.isNotEmpty) {
        print("🔐 [UserSessionBloc] Token exists, fetching user from API...");
        final result = await _fetchUser(token);

        if (result is ApiSucessResult<UserModel>) {
          print("✅ [UserSessionBloc] User fetched from API: ${result.sucessResult.firstName}");
          emit(state.copyWith(
            status: UserSessionStatus.authenticated,
            token: token,
            user: result.sucessResult,
          ));
        } else {
          print("⚠️ [UserSessionBloc] Failed to fetch user, status -> unauthenticated");
          emit(state.copyWith(status: UserSessionStatus.unauthenticated));
        }
      } else {
        print("❌ [UserSessionBloc] No token found, status -> unauthenticated");
        emit(state.copyWith(status: UserSessionStatus.unauthenticated));
      }
    });
    on<GuestLogin>((event, emit) {
      print("🔵 [UserSessionBloc] GuestLogin event triggered");

      emit(state.copyWith(
        status: UserSessionStatus.authenticatedGuest,
        token: null,
        user: null,
      ));
      print("✅ [UserSessionBloc] Status -> authenticatedGuest");
    });

  }

  Future<ApiResult<UserModel>> _fetchUser(String token) async {
    print("🌍 [UserSessionBloc] Calling authRepository.getLoggedInUser()");
    return await authRepository.getLoggedInUser();
  }
}
