abstract class HttpGetCall {
  Future<String> startRequest();

  setOnErrorListener(Function(Error error) onError);
}
