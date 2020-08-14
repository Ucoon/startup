import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

void getHttp() async {
  Response response = await Dio().get('http://www.baidu.com');
  print(response);
}

class HttpUtil extends DioForNative {}
