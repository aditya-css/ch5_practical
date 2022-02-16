// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_chopper_client.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$NewsChopperClient extends NewsChopperClient {
  _$NewsChopperClient([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NewsChopperClient;

  @override
  Future<Response<ApiResponse>> getTopNews() {
    final $url = '/top-headlines?country=in';
    final $headers = {
      'X-Api-Key': '5377d5133c384339aa839c6bcdfe9d6f',
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<ApiResponse, ApiResponse>($request);
  }
}
