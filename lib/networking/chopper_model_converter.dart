import 'dart:convert' show json, utf8;

import 'package:ch5_practical/networking/models/api_response_model.dart';
import 'package:chopper/chopper.dart';

class ChopperModelConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );

    return encodeJson(req);
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) =>
      decodeJson<BodyType, InnerType>(response);

  Request encodeJson(Request request) {
    var contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      var mapData = json.decode(body);
      var res = ApiResponse.fromJson(mapData);
      return response.copyWith<BodyType>(body: res as BodyType);
    } catch (e) {
      return response.copyWith<BodyType>(body: body);
    }
  }
}
