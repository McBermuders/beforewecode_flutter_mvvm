import 'package:http/http.dart' as http;
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/service/http_get_call.dart';

class HttpGetCallImpl implements HttpGetCall {
  late Function(Error error) _onError;
  final String clientURL;

  HttpGetCallImpl({required this.clientURL});

  @override
  Future<String> startRequest() async {
    return await fetchInformation(http.Client()).catchError((e) {
      if (e is Error) {
        _onError(e);
      }
      throw Exception(e);
    });
  }

  Future<String> fetchInformation(http.Client client) async {
    final response = await client.get(Uri.parse(clientURL));
    return response.body;
  }

  @override
  setOnErrorListener(Function(Error error) onError) {
    _onError = onError;
  }
}
