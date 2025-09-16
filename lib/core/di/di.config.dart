// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/services.dart' as _i281;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../features/address/api/client/adress_api_services.dart' as _i658;
import '../../features/address/api/data_source/adress_data_source_impl.dart'
    as _i107;
import '../../features/address/data/data_source/adress_data_source.dart'
    as _i535;
import '../../features/address/data/repositry/address_repositry_impl.dart'
    as _i246;
import '../../features/address/domain/repositry/address_repositry.dart' as _i52;
import '../../features/address/domain/use_case/get_add_address_use_case.dart'
    as _i671;
import '../../features/address/domain/use_case/get_all_address_use_case.dart'
    as _i808;
import '../../features/address/domain/use_case/get_all_cities_use_case.dart'
    as _i188;
import '../../features/address/domain/use_case/get_all_countries_use_case.dart'
    as _i946;
import '../../features/address/domain/use_case/get_all_governorate_use_case.dart'
    as _i648;
import '../../features/address/domain/use_case/get_delete_address_use_case.dart'
    as _i104;
import '../../features/address/domain/use_case/get_update_address_use_case.dart'
    as _i91;
import '../../features/address/presentation/view_model/address_bloc.dart'
    as _i1057;
import '../../features/auth/api/client/auth_api_service.dart' as _i522;
import '../../features/auth/api/source/auth_remote_data_souce_imp.dart'
    as _i669;
import '../../features/auth/data/repository/auth_repository_imp.dart' as _i794;
import '../../features/auth/data/source/auth_remote_data_source.dart' as _i777;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecase/forget_password_use_case.dart'
    as _i240;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/reset_password_use_case.dart'
    as _i878;
import '../../features/auth/domain/usecase/signup_usecase.dart' as _i472;
import '../../features/auth/domain/usecase/verfiy_password_use_case.dart'
    as _i197;
import '../../features/auth/presentation/view_model/forget_password/forget_password_cubit.dart'
    as _i1028;
import '../../features/auth/presentation/view_model/login_view_model/login_bloc.dart'
    as _i644;
import '../../features/auth/presentation/view_model/signup_view_model/signup_view_model.dart'
    as _i401;
import '../../features/cart/api/client/cart_api_service.dart' as _i942;
import '../../features/cart/api/source/cart_remote_data_souce_imp.dart'
    as _i296;
import '../../features/cart/data/repository/cart_respository_imp.dart' as _i9;
import '../../features/cart/data/source/cart_remote_data_souce.dart' as _i751;
import '../../features/cart/domain/repository/cart_repository.dart' as _i26;
import '../../features/cart/domain/usecase/add_to_cart_usecase.dart' as _i738;
import '../../features/cart/domain/usecase/delete_item_from_cart.dart' as _i472;
import '../../features/cart/domain/usecase/get_cart_of_user.dart' as _i29;
import '../../features/cart/domain/usecase/update_quatity.dart' as _i598;
import '../../features/cart/presentation/view_model/cart_view_model/cart_view_model.dart'
    as _i861;
import '../../features/checkout/api/client/checkout_api_service.dart' as _i252;
import '../../features/checkout/api/source/checkout_remote_data_source_imp.dart'
    as _i13;
import '../../features/checkout/data/repository/checkout_repository_imp.dart'
    as _i711;
import '../../features/checkout/data/source/checkout_remote_data_source.dart'
    as _i335;
import '../../features/checkout/domain/repository/checkout_repository.dart'
    as _i730;
import '../../features/checkout/domain/usecase/get_checkout_data_usecase.dart'
    as _i330;
import '../../features/checkout/domain/usecase/get_orders_by_checkout_url_usecase.dart'
    as _i27;
import '../../features/home/api/client/home_api_service.dart' as _i220;
import '../../features/home/api/source/home_remote_data_source_imp.dart'
    as _i265;
import '../../features/home/data/repository/home_repository_imp.dart' as _i342;
import '../../features/home/data/source/home_remote_data_source.dart' as _i557;
import '../../features/home/domain/repository/home_repository.dart' as _i541;
import '../../features/home/domain/usecase/get_home_data_usecase.dart' as _i630;
import '../../features/home/domain/usecase/get_products_by_category_id._usecase.dart'
    as _i438;
import '../../features/home/domain/usecase/get_products_detials_by_occasions.dart'
    as _i583;
import '../../features/home/domain/usecase/get_search_products_usecase.dart'
    as _i206;
import '../../features/home/domain/usecase/search_products_usecase.dart'
    as _i519;
import '../../features/home/presentation/view_model/categories_view_model/categories_view_model.dart'
    as _i604;
import '../../features/home/presentation/view_model/home_view_model/home_bloc.dart'
    as _i191;
import '../../features/home/presentation/view_model/occasion_view_model/occasion_bloc.dart'
    as _i1010;
import '../../features/home/presentation/view_model/search_view_model/search_bloc.dart'
    as _i717;
import '../../features/orders/api/client/orders_api_service.dart' as _i136;
import '../../features/orders/data/orders_remote_datasource.dart' as _i158;
import '../../features/orders/data/orders_remote_datasource_impl.dart' as _i620;
import '../../features/orders/data/repository/orders_remote_repo_impl.dart'
    as _i45;
import '../../features/orders/domain/repository/orders_repository.dart'
    as _i798;
import '../../features/orders/domain/usecase/get_orders_usecase.dart' as _i207;
import '../../features/orders/presentation/view_model/Orders_View_model.dart'
    as _i899;
import '../../features/profile/api/client/profile_api_service.dart' as _i495;
import '../../features/profile/api/source/local/profile_local_data_source_imp.dart'
    as _i752;
import '../../features/profile/api/source/remote/profile_remote_data_source_imp.dart'
    as _i246;
import '../../features/profile/data/repository/profile_repository_imp.dart'
    as _i335;
import '../../features/profile/data/source/local/profile_local_data_source.dart'
    as _i691;
import '../../features/profile/data/source/remote/profile_remote_data_source.dart'
    as _i368;
import '../../features/profile/domain/repository/profile_repository.dart'
    as _i364;
import '../../features/profile/domain/usecase/generate_json_section_sections_usecase.dart'
    as _i487;
import '../../features/profile/domain/usecase/get_change_password_use_case.dart'
    as _i568;
import '../../features/profile/domain/usecase/get_edit_profile_use_case.dart'
    as _i227;
import '../../features/profile/domain/usecase/get_upload_profile_photo_use_case.dart'
    as _i342;
import '../../features/profile/presentation/view_model/about_app/generic_json_section_bloc.dart'
    as _i1009;
import '../../features/profile/presentation/view_model/change_password_view_model/change_password_bloc.dart'
    as _i207;
import '../../features/profile/presentation/view_model/edit_profile/edit_profile_bloc.dart'
    as _i878;
import 'modules/dio_modules.dart' as _i288;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioModule.prettyDioLogger);
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.dio(gh<_i528.PrettyDioLogger>()));
    gh.factory<_i658.AddressesApiServices>(
        () => _i658.AddressesApiServices(gh<_i361.Dio>()));
    gh.factory<_i522.AuthApiService>(
        () => _i522.AuthApiService(gh<_i361.Dio>()));
    gh.factory<_i942.CartApiService>(
        () => _i942.CartApiService(gh<_i361.Dio>()));
    gh.factory<_i252.CheckoutApiService>(
        () => _i252.CheckoutApiService(gh<_i361.Dio>()));
    gh.factory<_i220.HomeApiService>(
        () => _i220.HomeApiService(gh<_i361.Dio>()));
    gh.factory<_i136.OrdersApiService>(
        () => _i136.OrdersApiService(gh<_i361.Dio>()));
    gh.factory<_i495.ProfileApiService>(
        () => _i495.ProfileApiService(gh<_i361.Dio>()));
    gh.factory<_i535.AddressRemoteDataSource>(
        () => _i107.AddressRemoteDataSourceImpl(
              gh<_i658.AddressesApiServices>(),
              gh<_i281.AssetBundle>(),
            ));
    gh.factory<_i691.ProfileLocalDataSource>(
        () => _i752.ProfileLocalDataSourceImp());
    gh.factory<_i368.ProfileRemoteDataSource>(
        () => _i246.ProfileRemoteDataSourceImp(gh<_i495.ProfileApiService>()));
    gh.factory<_i751.CartRemoteDataSouce>(
        () => _i296.CartRemoteDataSouceImp(gh<_i942.CartApiService>()));
    gh.factory<_i158.OrdersRemoteDataSource>(() =>
        _i620.OrdersRemoteDataSourceImpl(
            ordersApiService: gh<_i136.OrdersApiService>()));
    gh.factory<_i52.AddressRepositry>(
        () => _i246.AddressRepositryImpl(gh<_i535.AddressRemoteDataSource>()));
    gh.factory<_i798.OrdersRepository>(() => _i45.OrdersRepoImpl(
        ordersRemoteDataSource: gh<_i158.OrdersRemoteDataSource>()));
    gh.factory<_i26.CartRepository>(
        () => _i9.CartRespositoryImp(gh<_i751.CartRemoteDataSouce>()));
    gh.factory<_i671.GetAddAddressUseCase>(
        () => _i671.GetAddAddressUseCase(gh<_i52.AddressRepositry>()));
    gh.factory<_i808.GetAllAddressesUseCase>(
        () => _i808.GetAllAddressesUseCase(gh<_i52.AddressRepositry>()));
    gh.factory<_i188.GetAllStatesUseCase>(
        () => _i188.GetAllStatesUseCase(gh<_i52.AddressRepositry>()));
    gh.factory<_i946.GetAllCountriesUseCase>(
        () => _i946.GetAllCountriesUseCase(gh<_i52.AddressRepositry>()));
    gh.factory<_i648.GetAllGovernorateUseCase>(
        () => _i648.GetAllGovernorateUseCase(gh<_i52.AddressRepositry>()));
    gh.factory<_i104.GetDeleteAddressUseCase>(
        () => _i104.GetDeleteAddressUseCase(gh<_i52.AddressRepositry>()));
    gh.factory<_i91.GetUpdateAddressUseCase>(
        () => _i91.GetUpdateAddressUseCase(gh<_i52.AddressRepositry>()));
    gh.factory<_i557.HomeRemoteDataSource>(
        () => _i265.HomeRemoteDataSourceImp(gh<_i220.HomeApiService>()));
    gh.factory<_i541.HomeRepository>(
        () => _i342.HomeRepositoryImp(gh<_i557.HomeRemoteDataSource>()));
    gh.factory<_i438.GetProductsByCategoryIdUseCase>(
        () => _i438.GetProductsByCategoryIdUseCase(gh<_i541.HomeRepository>()));
    gh.factory<_i583.GetProductDetialsByOccasionUseCase>(() =>
        _i583.GetProductDetialsByOccasionUseCase(gh<_i541.HomeRepository>()));
    gh.factory<_i206.GetSearchProductsUsecase>(
        () => _i206.GetSearchProductsUsecase(gh<_i541.HomeRepository>()));
    gh.factory<_i519.SearchProductsUseCase>(
        () => _i519.SearchProductsUseCase(gh<_i541.HomeRepository>()));
    gh.factory<_i777.AuthRemoteDataSource>(
        () => _i669.AuthRemoteDataSourceImp(gh<_i522.AuthApiService>()));
    gh.factory<_i335.CheckoutRemoteDataSource>(
        () => _i13.CheckoutRemoteDataSourceImp(gh<_i252.CheckoutApiService>()));
    gh.factory<_i730.CheckoutRepository>(() =>
        _i711.CheckoutRepositoryImp(gh<_i335.CheckoutRemoteDataSource>()));
    gh.factory<_i207.GetOrdersUseCase>(
        () => _i207.GetOrdersUseCase(gh<_i798.OrdersRepository>()));
    gh.factory<_i717.SearchBloc>(
        () => _i717.SearchBloc(gh<_i519.SearchProductsUseCase>()));
    gh.factory<_i27.GetOrdersByCheckoutUrlUseCase>(() =>
        _i27.GetOrdersByCheckoutUrlUseCase(gh<_i730.CheckoutRepository>()));
    gh.factory<_i364.ProfileRepository>(() => _i335.ProfileRepositoryImp(
          gh<_i368.ProfileRemoteDataSource>(),
          gh<_i691.ProfileLocalDataSource>(),
        ));
    gh.factory<_i330.GetCheckoutDataUseCase>(
        () => _i330.GetCheckoutDataUseCase(gh<_i730.CheckoutRepository>()));
    gh.factory<_i738.AddToCartUsecase>(
        () => _i738.AddToCartUsecase(gh<_i26.CartRepository>()));
    gh.factory<_i472.DeleteItemFromCartUseCase>(
        () => _i472.DeleteItemFromCartUseCase(gh<_i26.CartRepository>()));
    gh.factory<_i29.GetCartOfUserUseCase>(
        () => _i29.GetCartOfUserUseCase(gh<_i26.CartRepository>()));
    gh.factory<_i598.UpdateQuatityUseCase>(
        () => _i598.UpdateQuatityUseCase(gh<_i26.CartRepository>()));
    gh.factory<_i630.GetHomeDataUseCase>(
        () => _i630.GetHomeDataUseCase(gh<_i541.HomeRepository>()));
    gh.factory<_i1057.AddressBloc>(() => _i1057.AddressBloc(
          gh<_i671.GetAddAddressUseCase>(),
          gh<_i808.GetAllAddressesUseCase>(),
          gh<_i104.GetDeleteAddressUseCase>(),
          gh<_i648.GetAllGovernorateUseCase>(),
          gh<_i188.GetAllStatesUseCase>(),
          gh<_i946.GetAllCountriesUseCase>(),
          gh<_i91.GetUpdateAddressUseCase>(),
        ));
    gh.factory<_i1010.ProductsDetialsOccasionBloc>(() =>
        _i1010.ProductsDetialsOccasionBloc(
            gh<_i583.GetProductDetialsByOccasionUseCase>()));
    gh.factory<_i487.GenerateJsonSectionsUseCase>(
        () => _i487.GenerateJsonSectionsUseCase(gh<_i364.ProfileRepository>()));
    gh.factory<_i568.GetChangePasswordUseCase>(
        () => _i568.GetChangePasswordUseCase(gh<_i364.ProfileRepository>()));
    gh.factory<_i227.GetEditProfileUseCase>(
        () => _i227.GetEditProfileUseCase(gh<_i364.ProfileRepository>()));
    gh.factory<_i342.GetUploadPhotoProfileUseCase>(() =>
        _i342.GetUploadPhotoProfileUseCase(gh<_i364.ProfileRepository>()));
    gh.factory<_i899.OrdersViewModel>(
        () => _i899.OrdersViewModel(gh<_i207.GetOrdersUseCase>()));
    gh.factory<_i604.CategoriesViewModel>(() => _i604.CategoriesViewModel(
          gh<_i438.GetProductsByCategoryIdUseCase>(),
          gh<_i206.GetSearchProductsUsecase>(),
        ));
    gh.factory<_i207.ChangePasswordBloc>(
        () => _i207.ChangePasswordBloc(gh<_i568.GetChangePasswordUseCase>()));
    gh.factory<_i961.AuthRepository>(
        () => _i794.AuthRepositoryImp(gh<_i777.AuthRemoteDataSource>()));
    gh.factory<_i878.EditProfileBloc>(() => _i878.EditProfileBloc(
          gh<_i342.GetUploadPhotoProfileUseCase>(),
          gh<_i227.GetEditProfileUseCase>(),
        ));
    gh.singleton<_i861.CartViewModel>(() => _i861.CartViewModel(
          gh<_i738.AddToCartUsecase>(),
          gh<_i29.GetCartOfUserUseCase>(),
          gh<_i472.DeleteItemFromCartUseCase>(),
          gh<_i598.UpdateQuatityUseCase>(),
        ));
    gh.factory<_i1009.GenericJsonSectionBloc>(() =>
        _i1009.GenericJsonSectionBloc(gh<_i487.GenerateJsonSectionsUseCase>()));
    gh.factory<_i191.HomeBloc>(
        () => _i191.HomeBloc(gh<_i630.GetHomeDataUseCase>()));
    gh.factory<_i472.SignupUsecase>(
        () => _i472.SignupUsecase(gh<_i961.AuthRepository>()));
    gh.factory<_i240.ForgetPasswordUseCase>(
        () => _i240.ForgetPasswordUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i878.ResetPasswordUseCase>(
        () => _i878.ResetPasswordUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i197.VerfiyPasswordUseCase>(
        () => _i197.VerfiyPasswordUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i911.LoginUsecase>(
        () => _i911.LoginUsecase(gh<_i961.AuthRepository>()));
    gh.factory<_i1028.ForgetPasswordBCubit>(() => _i1028.ForgetPasswordBCubit(
          gh<_i240.ForgetPasswordUseCase>(),
          gh<_i878.ResetPasswordUseCase>(),
          gh<_i197.VerfiyPasswordUseCase>(),
        ));
    gh.factory<_i644.LoginBloc>(
        () => _i644.LoginBloc(gh<_i911.LoginUsecase>()));
    gh.factory<_i401.SignupViewModel>(
        () => _i401.SignupViewModel(gh<_i472.SignupUsecase>()));
    return this;
  }
}

class _$DioModule extends _i288.DioModule {}
