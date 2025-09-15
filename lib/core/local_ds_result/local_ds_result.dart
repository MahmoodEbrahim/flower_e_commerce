sealed class LocalDsResult<t> {}

class LocalDsSucessResult<T> extends LocalDsResult<T> {
  T sucessResult;
  LocalDsSucessResult(this.sucessResult);
}

class LocalDsFailedResult<T> extends LocalDsResult<T> {
  String errorMessage;
  LocalDsFailedResult(this.errorMessage);
}