abstract interface class HttpGetCall {
  Future<String> startRequest();

  setOnErrorListener(Function(Error error) onError);
}
