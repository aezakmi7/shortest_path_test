import '../models/data_model.dart';

class JsonMapper {
  static List<DataModel> mapGameConfigs({dynamic decodedBody}) {
    return (decodedBody['data'] as List)
        .map((config) => DataModel.fromJson(config))
        .toList();
  }
}
