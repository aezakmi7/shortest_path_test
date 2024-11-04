import 'package:shortest_path_test/models/app_config_model.dart';

class JsonMapper {
  static List<AppConfigModel> mapAppConfigs({dynamic decodedBody}) {
    return (decodedBody['data'] as List)
        .map((config) => AppConfigModel.fromJson(config))
        .toList();
  }
}
