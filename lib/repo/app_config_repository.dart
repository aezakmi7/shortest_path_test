import 'dart:convert';
import 'dart:async';
import '../services/network_helper.dart';
import '../utils/json_mapper.dart';

import '../models/app_config_model.dart';
import '../models/calculating_result_model.dart';
import '../models/validating_result_model.dart';

abstract interface class IAppConfigRepo {
  Future<List<AppConfigModel>> getAppConfigs({required String endpoint});

  Future<ValidatingResultModel> sendResults(
      List<CalculatingResultModel> processingResults);
}

class AppConfigRepository implements IAppConfigRepo {
  final NetworkHelper _dataProvider = NetworkHelper();
  late String _lastEndpoint;

  @override
  Future<List<AppConfigModel>> getAppConfigs({required String endpoint}) async {
    try {
      final response = await _dataProvider.getRequest(url: endpoint);
      _lastEndpoint = endpoint;
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedBody = json.decode(response.body);
        return JsonMapper.mapAppConfigs(decodedBody: decodedBody);
      } else {
        throw 'Error loading app configs';
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ValidatingResultModel> sendResults(
      List<CalculatingResultModel> processingResults) async {
    try {
      var encoded = json.encode(processingResults);

      var response = await _dataProvider.postRequest(
        url: _lastEndpoint,
        jsonBody: encoded,
      );

      if (response.statusCode == 200) {
        return ValidatingResultModel.fromRawJson(response.body);
      } else {
        throw 'Error sending results';
      }
    } catch (e) {
      rethrow;
    }
  }
}
