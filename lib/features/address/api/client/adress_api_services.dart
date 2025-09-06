import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/constants/api_parameters.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/add_address_responsea.dart';
import 'package:flower_e_commerce/features/address/api/models/response/get_all_address_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/utils/constants/api_end_points.dart';
part 'adress_api_services.g.dart';
@RestApi( baseUrl:  ApiEndPoints.apiUrl)
@injectable
abstract class AddressesApiServices{
@factoryMethod
  factory AddressesApiServices(Dio dio)= _AddressesApiServices;
@PATCH(ApiEndPoints.addressEndPoint)
  Future<AddAddressResponse>addAddress(
    @Body()AddAdressRequest request,
    @Header(ApiParameters.authorization)String token
    );
@GET(ApiEndPoints.addressEndPoint)
  Future<GetAllAddressResponse>getAllAddress(
    @Header(ApiParameters.authorization)String token
    )
;

}