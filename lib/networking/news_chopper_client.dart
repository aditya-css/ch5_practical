import 'package:ch5_practical/networking/api_constants.dart';
import 'package:ch5_practical/networking/chopper_model_converter.dart';
import 'package:ch5_practical/networking/models/api_response_model.dart';
import 'package:chopper/chopper.dart';

part 'news_chopper_client.chopper.dart';

@ChopperApi(baseUrl: ApiConst.indiaHeadlines)
abstract class NewsChopperClient extends ChopperService {
  static NewsChopperClient create() {
    final client = ChopperClient(
      baseUrl: ApiConst.baseUrl,
      services: [_$NewsChopperClient()],
      converter: ChopperModelConverter(),
      errorConverter: const JsonConverter(),
    );
    return _$NewsChopperClient(client);
  }

  @Get(headers: <String, String>{'X-Api-Key': ApiConst.apiKey})
  Future<Response<ApiResponse>> getTopNews();
}
