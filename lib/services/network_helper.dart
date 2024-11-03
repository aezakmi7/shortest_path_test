import 'package:dio/dio.dart';

class NetworkHelper {
  final Dio dio;

  NetworkHelper({required this.dio});
  Future<dynamic> get({required String url}) async {
    try {
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
