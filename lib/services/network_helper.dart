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
}
