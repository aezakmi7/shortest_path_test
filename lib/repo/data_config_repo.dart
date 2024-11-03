import 'dart:convert';
import '../models/data_model.dart';
import '../services/network_helper.dart';
import '../utils/json_mapper.dart';

class DataConfigRepo {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<List<DataModel>> fetchDataConfigs({required String url}) async {
    final response = await _networkHelper.getResponse(url: url);
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedBody = jsonDecode(response.body);
      return JsonMapper.mapGameConfigs(decodedBody: decodedBody);
    }
    throw Exception('Failed to fetch data configs');
  }
}
