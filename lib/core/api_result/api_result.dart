sealed class ApiResult<t> {}

class ApiSucessResult<T> extends ApiResult<T> {
  T data;
  ApiSucessResult(this.data);
}

class ApiErrorResult<T> extends ApiResult<T> {
  String errorMessage;
  ApiErrorResult(this.errorMessage);
}
