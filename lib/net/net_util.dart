import 'package:dio/dio.dart';

class NetClient {
  NetClient._(this._dio);

  final Dio _dio;

  static NetClient? _instance;

  factory NetClient() {
    if (_instance == null) {
      final Dio dio = Dio(
        BaseOptions(baseUrl: 'http://api.apiopen.top/'),
      );
      dio.interceptors.add(_ErrorInter());
      _instance = NetClient._(dio);
    }
    return _instance!;
  }

  Future<dynamic> get(String url) => _dio.get(url);
}

class _ErrorInter extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('[REQUEST] ${options.uri.toString()}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[response] ${response.statusCode}');
    print('[response] ${response.data}');
    if (response.statusCode == 200) {
      final res = response.data as Map<String, dynamic>;
      if (res['code'] == 400) {
        handler.reject(
          DioError(requestOptions: response.requestOptions, error: 'error'),
        );
        return;
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
