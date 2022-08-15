import 'api_manager.dart';
export 'api_manager.dart' show ApiCallResponse;

class JsonlistsCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'jsonlists',
      apiUrl: 'https://mocki.io/v1/b5eb918f-73e6-42bd-bed2-28d63d84c3dd',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}
