import 'package:http/http.dart' as http;

class NetworkHelper {
  Future<http.Response> getRequest({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> postRequest(
      {required String url, required String jsonBody}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
