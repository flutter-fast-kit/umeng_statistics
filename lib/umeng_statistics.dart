import 'dart:async';
import 'dart:collection';

import 'package:flutter/services.dart';

class UmengStatistics {
  static const MethodChannel _channel = MethodChannel('umeng_statistics');

  /// 初始化Appkey
  ///
  /// * androidAppKey : 友盟android AppKey
  /// * iOSAppKey  : 友盟iOS AppKey
  /// * channel : 渠道
  /// * logEnabled ： 开启日志
  /// * encryptEnabled ：加密
  /// * processEvent ：子进程中对自定义事件进行统计
  static Future<bool?> initAppKey(String androidAppKey, String iosAppKey, String channel,
      {bool logEnabled = false, bool encryptEnabled = false, bool processEvent = false}) async {
    final Map<String, dynamic> params = HashMap<String, dynamic>();
    params['android'] = androidAppKey;
    params['ios'] = iosAppKey;
    params['channel'] = channel;
    params['logEnabled'] = logEnabled;
    params['encryptEnabled'] = encryptEnabled;
    params['processEvent'] = processEvent;
    return await _channel.invokeMethod<bool>('initAppKey', params);
  }

  /// 事件统计功能
  static Future<bool?> onEvent(String id, Map<String, Object> data) async {
    final Map<String, Object> params = HashMap();
    params['id'] = id;
    params['data'] = data;
    return await _channel.invokeMethod<bool>('onEvent', params);
  }

  /// 设置用户账户
  static Future<bool?> onProfileSignIn(String userID) async {
    final Map<String, Object> params = HashMap();
    params['userID'] = userID;
    return await _channel.invokeMethod<bool>('onProfileSignIn', params);
  }

  /// 取消用户账户
  static Future<bool?> onProfileSignOff() async {
    return await _channel.invokeMethod<bool>('onProfileSignOff');
  }

  /// 自动采集页面
  static Future<bool?> setPageCollectionModeAuto() async {
    return await _channel.invokeMethod('setPageCollectionModeAuto');
  }

  /// 手动采集页面
  static Future<bool?> setPageCollectionModeManual() async {
    return await _channel.invokeMethod<bool>('setPageCollectionModeManual');
  }

  /// 自动页面时长统计，必须配对使用
  static Future<bool?> onPageStart(String viewName) async {
    final Map<String, Object> params = HashMap();
    params['viewName'] = viewName;
    return await _channel.invokeMethod<bool>('onPageStart', params);
  }

  /// 结束页面时长统计，必须配对使用
  static Future<bool?> onPageEnd(String viewName) async {
    final Map<String, Object> params = HashMap();
    params['viewName'] = viewName;
    return await _channel.invokeMethod<bool>('onPageEnd', params);
  }
}
