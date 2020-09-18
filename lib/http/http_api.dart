import 'package:dio/dio.dart';

import 'http_config.dart';

/// 网络请求库
/// [author] junpu
/// [date] 2020/9/15
class HttpApi {
  /// 全局基础配置
  static final baseOptions = BaseOptions(
    baseUrl: HttpConfig.BASE_URL,
    connectTimeout: HttpConfig.TIME_OUT_MILLS,
    sendTimeout: HttpConfig.TIME_OUT_MILLS,
    receiveTimeout: HttpConfig.TIME_OUT_MILLS,
  );
  static final dio = Dio(baseOptions);

  /// 网络请求
  static Future<T> request<T>(
    String url, {
    String method = 'get',
    Map<String, dynamic> params,
    Interceptor interceptor,
  }) async {
    // 1. 添加单独的配置
    var options = Options(method: method);

    // 2. 添加全局拦截器
    var baseInterceptor = InterceptorsWrapper(
      onRequest: (request) {
        // 1.在进行任何网络请求的时候, 可以添加一个loading显示
        // 2.很多页面的访问必须要求携带Token,那么就可以在这里判断是有Token
        // 3.对参数进行一些处理,比如序列化处理等
        print('拦截了请求 request: $request');
      },
      onResponse: (response) {
        print('拦截了 结果 response: $response');
      },
      onError: (e) {
        print('拦截了错误 error: $e');
      },
    );
    List<Interceptor> inters = [baseInterceptor];
    if (interceptor != null) inters.add(interceptor);
    dio.interceptors.addAll(inters);

    // 3. 发送网络请求
    try {
      Response response = await dio.request<T>(
        url,
        data: params,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }

  /// get
  static Future<T> get<T>(
    String url, {
    Map<String, dynamic> params,
    Interceptor interceptor,
  }) {
    return request(url, params: params, interceptor: interceptor);
  }

  /// post
  static Future<T> post<T>(
    String url, {
    Map<String, dynamic> params,
    Interceptor interceptor,
  }) {
    return request(url,
        method: 'post', params: params, interceptor: interceptor);
  }
}
