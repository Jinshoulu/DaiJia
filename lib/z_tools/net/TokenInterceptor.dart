import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import '../../public_header.dart';
import '../app_bus_event.dart';
import 'DioUtils.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    bool loginState = SpUtil.getBool(AppValue.login_state, defValue: false); //是否登录
    String url = options.baseUrl + options.path;
    if (loginState||(url==Api.uploadSignImageUrl)) {
      DioUtils.instance.dio.lock();
      int loginExpiration = SpUtil.getInt(AppValue.token_expiration); //USER_TOKEN过期时间
      int currentTime = (DateTime.now().millisecondsSinceEpoch) ~/ 1000; //获取当前时间戳10位

      print('过期时间 ----------> $loginExpiration');
      print('当前时间 ----------> $currentTime');
      if (currentTime >= loginExpiration) {

        try {
          BaseOptions _baseOptions = BaseOptions(
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            receiveDataWhenStatusError: true,
            connectTimeout: 15000,
            receiveTimeout: 15000,
            validateStatus: (status) {
              // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
              return true;
            },
          );
          Dio dio = new Dio(_baseOptions);
          var data = {"refertoken": '${SpUtil.getString(AppValue.refresh_token)}'};
          print("刷新的USER_TOKEN参数:" + data.toString());

          var response = await dio.post(Api.refreshTokenUrl, data: data);
          print("刷新USER_TOKEN结果：" + response.data.toString());
          var result = response.data;
          if (result['code'] == 1) {
            //{
            //  "msg": "success",
            //  "code": 1,
            //  "data": {
            //    "USER_TOKEN": "1c128074d4db682524652243826cc90b",
            //    "referUSER_TOKEN": "0128d04767010ed3745d99069c047ea2646f1af4",
            //    "expiration": 1594273699,
            //    "uid": "1",
            //    "type": "3"
            //  }
            //}
            SpUtil.putString(AppValue.token, result['data']['token']);
            SpUtil.putString( AppValue.refresh_token, result['data']['refertoken']);
            SpUtil.putInt(  AppValue.token_expiration, result['data']['expiration']);
            print("刷新USER_TOKEN成功" + SpUtil.getString(AppValue.token));
            DioUtils.instance.dio.unlock();
          } else {
            DioUtils.instance.dio.clear();
            DioUtils.instance.dio.unlock();
            print("刷新USER_TOKEN失败=>${result['code']}");
            print("刷新USER_TOKEN失败=>${result['msg']}");
            SpUtil.putBool(AppValue.login_state, false);
            //todo 重新登录
            eventBus.fire(ExitApp());
          }
        } catch (e) {
          DioUtils.instance.dio.clear();
          DioUtils.instance.dio.unlock();
          print("刷新USER_TOKEN失败异常=>${e.toString()}");
          //todo 重新登录
          SpUtil.putBool(AppValue.login_state, false);
          eventBus.fire(ExitApp());
        }
      } else {
        DioUtils.instance.dio.unlock();
      }
      options.headers["token"] = SpUtil.getString(AppValue.token); //请求添加USER_TOKEN
    }
    return super.onRequest(options);
  }
}
