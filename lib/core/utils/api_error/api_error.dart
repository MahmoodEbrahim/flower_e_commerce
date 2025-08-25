import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';



class ServerFailure extends  ApiErrorResult {
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioError(DioException dioException){
    switch(dioException.type){
      case DioExceptionType.connectionTimeout:
        return ServerFailure("ServerFailure with Api Server");
      case DioExceptionType.sendTimeout:
        return ServerFailure("sendTimeout with Api Server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("receiveTimeout with Api Server");
      case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response!.statusCode,
            dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(" ServerFailure with Api Server was canceled");
      case DioExceptionType.connectionError:
        return ServerFailure(" ServerFailure with Api Server have an error");
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }
  factory ServerFailure.fromResponse(dynamic? statusCode, dynamic response) {
    if (statusCode == "400" || statusCode == "401" || statusCode == "403") {
      return ServerFailure(response['error']);
    } else if (statusCode == '404') {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == "500") {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}