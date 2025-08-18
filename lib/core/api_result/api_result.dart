
sealed class ApiResult<t> {}

class ApiSucessResult<T> extends ApiResult<T> {
  T sucessResult;
  ApiSucessResult(this.sucessResult);
}

class ApiFailedResult<T> extends ApiResult<T> {
  String errorMessage;
  ApiFailedResult(this.errorMessage);


}

