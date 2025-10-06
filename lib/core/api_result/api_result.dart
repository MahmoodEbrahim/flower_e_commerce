sealed class Result<t> {}

class SucessResult<T> extends Result<T> {
  T sucessResult;
  SucessResult(this.sucessResult);
}

class FailedResult<T> extends Result<T> {
  String errorMessage;

  FailedResult(this.errorMessage);
}
